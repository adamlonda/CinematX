//
//  MovieDatabaseProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import RxSwift

protocol MovieDatabaseProtocol {
    associatedtype ImageType
    func getPopularMovies(with languageCode: String) -> Observable<MovieViewModel<ImageType>>
}

class MovieDatabaseWith<ImageType>: MovieDatabaseProtocol {
    func getPopularMovies(with languageCode: String) -> Observable<MovieViewModel<ImageType>> {
        fatalError()
    }
}
