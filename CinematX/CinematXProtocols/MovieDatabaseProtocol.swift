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
    func getMovie(from info: MovieInfo, with genreMap: [Int: String]) -> Future<Movie<ImageType>>
    func getPopularMoviesInfo(with languageCode: String) -> Future<[MovieInfo]>
    func getGenreMap(with languageCode: String) -> Future<[Int: String]>
}

class MovieDatabaseWith<ImageType>: MovieDatabaseProtocol {
    func getMovie(from info: MovieInfo, with genreMap: [Int: String]) -> Future<Movie<ImageType>> {
        fatalError()
    }
    
    func getPopularMoviesInfo(with languageCode: String) -> Future<[MovieInfo]> {
        fatalError()
    }
    
    func getGenreMap(with languageCode: String) -> Future<[Int: String]> {
        fatalError()
    }
}
