//
//  SongDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Роман Колосов on 29.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SongDetailHeaderViewController: UIViewController {
    
    // MARK: - Subviews
    private var appDetailHeaderView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    // MARK: - Services
    private let imageDownLoader = ImageDownloader()
    
    // MARK: - Some properties
    private let song: ITunesSong
    
    // MARK: - Cache
    private var cache: Dictionary<String, UIImage> = [:]
    
    // MARK: - Initilizers
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillSongData()
    }
    
    // MARK: - Major methods
    
    private func fillSongData() {
        downloadImage()
        appDetailHeaderView.titleLabel.text = song.trackName
        appDetailHeaderView.subtitleLabel.text = song.artistName
        appDetailHeaderView.ratingLabel.text = ""
    }
    
    private func downloadImage() {
        guard let url = self.song.artwork else { return }
        
        guard let image = cache[url] else {
            
            imageDownLoader.getImage(fromUrl: url) { [weak self] (image, _) in
                guard let self = self else { return }
                self.cache[url] = image
                
                DispatchQueue.main.async {
                    self.appDetailHeaderView.imageView.image = image
                }
            }
            return
        }
        appDetailHeaderView.imageView.image = image
    }
}
