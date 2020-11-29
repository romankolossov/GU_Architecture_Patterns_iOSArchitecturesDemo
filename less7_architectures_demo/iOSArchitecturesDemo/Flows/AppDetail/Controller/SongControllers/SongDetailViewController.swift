//
//  SongDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Роман Колосов on 29.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

final class SongDetailViewController: UIViewController {
    
    // MARK: - Subviews
    private var appDetailView: AppDetailView {
        return self.view as! AppDetailView
    }
    // MARK: - Controllers
    lazy var headerViewController = SongDetailHeaderViewController(song: song)
    lazy var songDetailWhatsNewViewController = SongDetailWhatsNewViewController(song: song)
    
    // MARK: - Some properties
    public var song: ITunesSong
    
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
        super.loadView()
        self.view = AppDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Major private methods
    
    private func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        
        addChildViewController()
        addDescriptionViewController()
    }
    
    private func addChildViewController() {
        self.addChild(headerViewController)
        self.view.addSubview(headerViewController.view)
        
        self.headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func addDescriptionViewController() {
        
        self.addChild(songDetailWhatsNewViewController)
        self.view.addSubview(songDetailWhatsNewViewController.view)
        
        songDetailWhatsNewViewController.didMove(toParent: self)
        
        songDetailWhatsNewViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            songDetailWhatsNewViewController.view.topAnchor.constraint(equalTo: headerViewController.view.bottomAnchor),
            songDetailWhatsNewViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            songDetailWhatsNewViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            songDetailWhatsNewViewController.view.heightAnchor.constraint(equalToConstant: 136.0)
        ])
    }
}
