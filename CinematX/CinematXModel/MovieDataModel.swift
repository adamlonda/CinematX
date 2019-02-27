//
//  MovieDataModel.swift
//  CinematX
//
//  Created by Adam Londa on 27/02/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

struct MovieDataModel {
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
