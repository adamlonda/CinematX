//
//  MovieDatabaseProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Microfutures

protocol MovieDatabaseProtocol {
    associatedtype ImageType
    func getPopularMovies(languageCode: String) -> Future<[MovieItem]>
}

class MovieDatabaseWith<ImageType>: MovieDatabaseProtocol {
    func getPopularMovies(languageCode: String) -> Future<[MovieItem]> {
        fatalError()
    }
}
