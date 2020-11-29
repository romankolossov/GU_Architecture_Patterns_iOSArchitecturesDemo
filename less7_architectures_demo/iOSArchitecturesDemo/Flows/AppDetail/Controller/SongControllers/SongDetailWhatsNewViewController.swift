//
//  SongDetailWhatsNewViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Роман Колосов on 29.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SongDetailWhatsNewViewController: UIViewController {
    
    // MARK: - Subviews
    private var appDetailWhatsNewView: AppDetailWhatsNewView {
        return self.view as! AppDetailWhatsNewView
    }
    // MARK: - Some properties
    private let song: ITunesSong
    
    // MARK: - Initializers
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = AppDetailWhatsNewView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillSongData()
    }
    
    // MARK: - Major methods
    
    private func fillSongData() {
        appDetailWhatsNewView.titleLabel.text = "Детали"
        appDetailWhatsNewView.subtitleLabel.text = song.trackName
        appDetailWhatsNewView.descriptionLabel.text = song.artwork
        appDetailWhatsNewView.versionLogLabel.text = "Исполнитель"
        appDetailWhatsNewView.lastVersionIssueLabel.text = song.artistName
    }
}

