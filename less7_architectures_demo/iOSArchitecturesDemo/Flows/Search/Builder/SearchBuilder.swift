//
//  SearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 17.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SearchBuilder {
    
    static func build() -> (UIViewController & SearchViewInput) {
        let presenter = SearchPresenter()
        let presenterSong = SearchSongPresenter()
        
        let viewController = SearchViewController(presenter: presenter, presenterSong: presenterSong)
        
        presenter.viewInput = viewController
        presenterSong.viewInput = viewController
        
        return viewController
    }
}
