//
//  MovieItem.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Foundation

struct MovieInfo {
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let genreIds: [Int]
    
    init(title: String, overview: String, posterPath: String, releaseDate: String, genreIds: [Int]) {
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
}

struct Movie<ImageType> {
    let title: String
    let overview: String
    let poster: ImageType
    let releaseDate: Date
    let genres: [String]
    
    init(title: String, overview: String, poster: ImageType, releaseDate: Date, genres: [String]) {
        self.title = title
        self.overview = overview
        self.poster = poster
        self.releaseDate = releaseDate
        self.genres = genres
    }
}
