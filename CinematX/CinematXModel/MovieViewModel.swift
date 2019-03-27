//
//  MovieViewModel.swift
//  CinematX
//
//  Created by Adam Londa on 27/02/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Foundation
import UIKit

struct MovieViewModel {
    let title: String
    let overview: String
    let poster: UIImage
    let releaseDate: Date
    let genres: [String]

    init(title: String, overview: String, poster: UIImage, releaseDate: Date, genres: [String]) {
        self.title = title
        self.overview = overview
        self.poster = poster
        self.releaseDate = releaseDate
        self.genres = genres
    }
}
