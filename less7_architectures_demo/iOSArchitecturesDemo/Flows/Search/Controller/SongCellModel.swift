//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Роман Колосов on 29.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let trackTitle: String
    let artistName: String?
    let collectionName: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(trackTitle: model.trackName,
                            artistName: model.artistName,
                            collectionName: model.collectionName)
    }
}

