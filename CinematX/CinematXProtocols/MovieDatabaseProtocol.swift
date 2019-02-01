//
//  MovieDatabaseProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

protocol MovieDatabaseProtocol {
    associatedtype ImageType
    func getPopularMovies(languageCode: String, completion: @escaping (Result<[MovieItem]>) -> Void)
}

class MovieDatabaseWith<ImageType>: MovieDatabaseProtocol {
    func getPopularMovies(languageCode: String, completion: @escaping (Result<[MovieItem]>) -> Void) {
        fatalError()
    }
}
