//
//  AppDetailWhatsNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Роман Колосов on 24.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailWhatsNewView: UIView {
    
    // UI
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.numberOfLines = 30
        return label
    }()
    private(set) lazy var versionLogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var lastVersionIssueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Major methods
    
    private func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(versionLogLabel)
        self.addSubview(lastVersionIssueLabel)
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            titleLabel.widthAnchor.constraint(equalToConstant: 120.0)
        ]
        let subtitleLabelConstraints = [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 120.0),
        ]
        
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        let versionLogLabelConstraints = [
            versionLogLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            versionLogLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 68.0),
            versionLogLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 12)
        ]
        
        let lastVersionIssueLabelConstraints = [
            lastVersionIssueLabel.topAnchor.constraint(equalTo: versionLogLabel.bottomAnchor, constant: 12.0),
            lastVersionIssueLabel.leadingAnchor.constraint(equalTo: versionLogLabel.leadingAnchor),
            lastVersionIssueLabel.trailingAnchor.constraint(equalTo: versionLogLabel.trailingAnchor),
        ]
        NSLayoutConstraint.activate(titleLabelConstraints + subtitleLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints + versionLogLabelConstraints)
        NSLayoutConstraint.activate(lastVersionIssueLabelConstraints)
    }
}



