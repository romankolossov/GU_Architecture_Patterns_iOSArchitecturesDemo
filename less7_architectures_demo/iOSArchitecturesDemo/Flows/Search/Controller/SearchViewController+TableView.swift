//
//  SearchViewController+TableView.swift
//  iOSArchitecturesDemo
//
//  Created by Роман Колосов on 29.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch publicSearchView.selectedSearch {
        case .byApplication:
            return searchResults.count
        case .bySong:
            return searchSongResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: publicReuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? AppCell else {
            return dequeuedCell
        }
        
        switch publicSearchView.selectedSearch {
        case .byApplication:
            let app = self.searchResults[indexPath.row]
            let cellModel = AppCellModelFactory.cellModel(from: app)
            cell.configure(with: cellModel)
        case .bySong:
            let song = self.searchSongResults[indexPath.row]
            let cellSongModel = SongCellModelFactory.cellModel(from: song)
            cell.configureSong(with: cellSongModel)
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch publicSearchView.selectedSearch {
        case .byApplication:
            guard !searchResults.isEmpty else { return }
            
            let app = searchResults[indexPath.row]
            let appDetaillViewController = AppDetailViewController(app: app)
            
            appDetaillViewController.app = app
            publicPresenter.viewDidSelectApp(app)
        case .bySong:
            guard !searchSongResults.isEmpty else { return }
            
            let song = searchSongResults[indexPath.row]
            let songDetailViewController = SongDetailViewController(song: song)
            
            songDetailViewController.song = song
            publicPresenterSong.viewDidSelectSong(song)
        }
        // navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}
