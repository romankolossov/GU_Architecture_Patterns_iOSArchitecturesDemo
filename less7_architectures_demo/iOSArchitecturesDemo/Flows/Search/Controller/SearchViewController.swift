//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    private let searchService = ITunesSearchService()
    
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
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    private let presenter: SearchViewOutput
    private let presenterSong: SearchSongViewOutput
    
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

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //searchResults.count
        searchSongResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? AppCell else {
            return dequeuedCell
        }
        //let app = self.searchResults[indexPath.row]
        //let cellModel = AppCellModelFactory.cellModel(from: app)
        
        let song = self.searchSongResults[indexPath.row]
        let cellSongModel = SongCellModelFactory.cellModel(from: song)
        
        //cell.configure(with: cellModel)
        
        cell.configureSong(with: cellSongModel)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let app = searchResults[indexPath.row]
        let appDetaillViewController = AppDetailViewController(app: app)
        appDetaillViewController.app = app
        presenter.viewDidSelectApp(app)
//        navigationController?.pushViewController(appDetaillViewController, animated: true)
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
        
//        presenter.viewDidSearch(with: query)
        presenterSong.viewDidSearch(with: query)
        
//        self.requestApps(with: query)
    }
}

//MARK: - SearchViewInput, SearchSongViewInput

extension SearchViewController: SearchViewInput, SearchSongViewInput {
    
    // MARK: - Private
    
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
