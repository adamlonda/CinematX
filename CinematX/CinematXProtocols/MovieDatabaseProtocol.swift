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
    func getMovie(from info: MovieInfo) -> Future<Movie<ImageType>>
    func getPopularMoviesInfo(with languageCode: String) -> Future<[MovieInfo]>
}

class MovieDatabaseWith<ImageType>: MovieDatabaseProtocol {
    func getMovie(from info: MovieInfo) -> Future<Movie<ImageType>> {
        fatalError()
    }
    
    func getPopularMoviesInfo(with languageCode: String) -> Future<[MovieInfo]> {
        fatalError()
    }
}
