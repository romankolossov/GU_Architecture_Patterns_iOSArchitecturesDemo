//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Subviews
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    public var publicSearchView: SearchView {
        searchView
    }
    
    // MARK: - Services
    private let searchService = ITunesSearchService()
    
    // MARK: - Some properties
    var searchResults = [ITunesApp]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    var searchSongResults = [ITunesSong]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - Constants
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    public var publicReuseIdentifier: String {
        Constants.reuseIdentifier
    }
    
    // MARK: - Presenters
    private let presenter: SearchViewOutput
    public var publicPresenter: SearchViewOutput {
        presenter
    }
    private let presenterSong: SearchSongViewOutput
    public var publicPresenterSong: SearchSongViewOutput {
        presenterSong
    }
    
    // MARK: - Initializers
    
    init(presenter: SearchViewOutput, presenterSong: SearchSongViewOutput) {
        self.presenter = presenter
        self.presenterSong = presenterSong
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        
        switch searchView.selectedSearch {
        case .byApplication:
            presenter.viewDidSearch(with: query)
        case .bySong:
            presenterSong.viewDidSearch(with: query)
        }
        // self.requestApps(with: query)
    }
}

//MARK: - SearchViewInput, SearchSongViewInput

extension SearchViewController: SearchViewInput, SearchSongViewInput {
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
}
