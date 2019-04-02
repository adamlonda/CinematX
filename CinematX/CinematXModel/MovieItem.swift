//
//  MovieItem.swift
//  CinematX
//
//  Created by Adam Londa on 27/02/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Foundation
import UIKit

struct MovieItemDataModel {
    let id: Int
    let title: String
//    let overview: String
    let posterPath: String
//    let releaseDate: String
//    let genreIds: [Int]
    
    init(id: Int, title: String, posterPath: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
    }

//    init(id: Int, title: String, overview: String, posterPath: String, releaseDate: String, genreIds: [Int]) {
//        self.id = id
//        self.title = title
//        self.overview = overview
//        self.posterPath = posterPath
//        self.releaseDate = releaseDate
//        self.genreIds = genreIds
//    }
}

struct MovieItemViewModel {
    let id: Int
    let title: String
//    let overview: String
    let poster: UIImage
//    let releaseDate: Date
//    let genres: [String]
    
    init(id: Int, title: String, poster: UIImage) {
        self.id = id
        self.title = title
        self.poster = poster
    }
    
//    init(id: Int, title: String, overview: String, poster: UIImage, releaseDate: Date, genres: [String]) {
//        self.id = id
//        self.title = title
//        self.overview = overview
//        self.poster = poster
//        self.releaseDate = releaseDate
//        self.genres = genres
//    }
}
