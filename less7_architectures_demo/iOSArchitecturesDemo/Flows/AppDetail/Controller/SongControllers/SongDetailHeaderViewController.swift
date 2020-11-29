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
    // MARK: - Some properties
    private let song: ITunesSong
    
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
        //appDetailHeaderView.imageView.image = image
        appDetailHeaderView.titleLabel.text = song.trackName
        appDetailHeaderView.subtitleLabel.text = song.artistName
        appDetailHeaderView.ratingLabel.text = song.collectionName
    }
}
