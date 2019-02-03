//
//  ParsingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

protocol ParsingProtocol {
    associatedtype UnparsedData
    func getPopularMovies(from: UnparsedData) throws -> [MovieItem]
}

class Parser<T>: ParsingProtocol {
    typealias UnparsedData = T
    
    func getPopularMovies(from: T) throws -> [MovieItem] {
        fatalError()
    }
}
