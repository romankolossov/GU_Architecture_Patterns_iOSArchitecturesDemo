//
//  AppDetailWhatsNewViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Роман Колосов on 24.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailWhatsNewViewController: UIViewController {
    
    private let app: ITunesApp
    
    private var appDetailWhatsNewView: AppDetailWhatsNewView {
        return self.view as! AppDetailWhatsNewView
    }
    
    // Initializers
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailWhatsNewView()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func fillData() {
        appDetailWhatsNewView.titleLabel.text = "Что нового"
        appDetailWhatsNewView.subtitleLabel.text = app.company
        appDetailWhatsNewView.descriptionLabel.text = app.appDescription
        appDetailWhatsNewView.versionLogLabel.text = "Рейтинг последней версии"
        appDetailWhatsNewView.lastVersionIssueLabel.text = app.averageRatingForCurrentVersion.flatMap { "\($0)" }
    }
}

