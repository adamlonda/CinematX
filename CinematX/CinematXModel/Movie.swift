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
    
    init(title: String, overview: String, posterPath: String, releaseDate: String) {
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
}

struct Movie<ImageType> {
    let title: String
    let overview: String
    let poster: ImageType
    let releaseDate: Date
    
    init(info: MovieInfo, poster: ImageType, releaseDate: Date) {
        self.title = info.title
        self.overview = info.overview
        self.poster = poster
        self.releaseDate = releaseDate
    }
}
