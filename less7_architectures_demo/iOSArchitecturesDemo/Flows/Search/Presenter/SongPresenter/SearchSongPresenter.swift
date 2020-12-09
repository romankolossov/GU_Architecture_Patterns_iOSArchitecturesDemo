//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Роман Колосов on 29.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchSongViewInput: AnyObject {
    var searchSongResults: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchSongViewOutput: AnyObject {
    func viewDidSearch(with query: String)
    func viewDidSelectSong(_ song: ITunesSong)
}

class SearchSongPresenter {
    private let searchService = ITunesSearchService()
    
    weak var viewInput: (UIViewController & SearchSongViewInput)?
    
    
    private func requestSongs(with query: String) {
        searchService.getSongs(forQuery: query) { [weak self] (result) in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result.withValue { (songs) in
                guard !songs.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchSongResults = songs
            }.withError { (error) in
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    private func openSongDetails(with song: ITunesSong) {
        let songDetailViewController = SongDetailViewController(song: song)
        
        viewInput?.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
}

extension SearchSongPresenter: SearchSongViewOutput {
    func viewDidSearch(with query: String) {
        requestSongs(with: query)
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
        openSongDetails(with: song)
    }
}

