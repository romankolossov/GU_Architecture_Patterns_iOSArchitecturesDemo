//
//  SearchView.swift
//  iOSArchitecturesDemo
//
//  Created by Evgeny Kireev on 02/06/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SearchView: UIView {
    
    // MARK: - Subviews
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let emptyResultView = UIView()
    let emptyResultLabel = UILabel()
    let searchSegmentControl = UISegmentedControl()
    
    // MARK: - Some properties
    
    var selectedSearch: SearchMode {
        switch searchSegmentControl.selectedSegmentIndex {
        case 0:
            return .byApplication
        case 1:
            return.bySong
        default:
            return .byApplication
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSearchBar()
        self.addSearchSegmentControl()
        self.addTableView()
        self.addEmptyResultView()
        self.setupConstraints()
    }
    
    // MARK: Major methods
    
    private func addSearchBar() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.searchBarStyle = .minimal
        self.addSubview(self.searchBar)
    }
    
    private func addSearchSegmentControl() {
        self.searchSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.searchSegmentControl.removeAllSegments()
        self.searchSegmentControl.insertSegment(withTitle: "Applications", at: 0, animated: true)
        self.searchSegmentControl.insertSegment(withTitle: "Songs", at: 1, animated: true)

        let attr = NSDictionary(object: UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .subheadline), size: 15), forKey: NSAttributedString.Key.font as NSCopying)
        self.searchSegmentControl.setTitleTextAttributes(attr as? [NSAttributedString.Key : Any] , for: .normal)
        
        self.addSubview(self.searchSegmentControl)
    }
    
    private func addTableView() {
        self.tableView.rowHeight = 72.0
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 0.0)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        self.addSubview(self.tableView)
    }
    
    private func addEmptyResultView() {
        self.emptyResultView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultView.backgroundColor = .white
        self.emptyResultView.isHidden = true
        
        self.emptyResultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultLabel.text = "Nothing was found"
        self.emptyResultLabel.textColor = UIColor.darkGray
        self.emptyResultLabel.textAlignment = .center
        self.emptyResultLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        self.addSubview(self.emptyResultView)
        self.emptyResultView.addSubview(self.emptyResultLabel)
    }
    
    // MARK: - Setup constraints
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            self.searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            self.searchSegmentControl.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.searchSegmentControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchSegmentControl.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.emptyResultView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.emptyResultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.emptyResultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.emptyResultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.emptyResultLabel.topAnchor.constraint(equalTo: self.emptyResultView.topAnchor, constant: 12.0),
            self.emptyResultLabel.leadingAnchor.constraint(equalTo: self.emptyResultView.leadingAnchor),
            self.emptyResultLabel.trailingAnchor.constraint(equalTo: self.emptyResultView.trailingAnchor)
            ])
    }
}
