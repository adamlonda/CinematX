//
//  MovieDatabaseProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

protocol MovieDatabaseProtocol {
    func getPopularMovies() -> [MovieItem]
}
