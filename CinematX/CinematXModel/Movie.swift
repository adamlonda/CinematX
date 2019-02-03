//
//  MovieItem.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

struct MovieInfo {
    let title: String
    let overview: String
    let posterPath: String
    
    init(title: String, overview: String, posterPath: String) {
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
    }
}

struct Movie<ImageType> {
    let title: String
    let overview: String
    let poster: ImageType
    
    init(info: MovieInfo, poster: ImageType) {
        self.title = info.title
        self.overview = info.overview
        self.poster = poster
    }
}
