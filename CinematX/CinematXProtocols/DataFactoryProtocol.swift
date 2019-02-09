//
//  ParsingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

protocol DataFactoryProtocol {
    associatedtype UnparsedData
    associatedtype ImageType
    
    func getMovieInfo(from response: UnparsedData) throws -> MovieInfo
    func getMovie(from info: MovieInfo, with poster: ImageType, genreMap: [Int: String]) throws -> Movie<ImageType>
    func getGenreMap(from response: UnparsedData) throws -> [Int: String]
}

class DataFactory<FromType, WithImage>: DataFactoryProtocol {
    typealias UnparsedData = FromType
    typealias ImageType = WithImage
    
    func getMovieInfo(from response: UnparsedData) throws -> MovieInfo {
        fatalError()
    }
    
    func getMovie(from info: MovieInfo, with poster: ImageType, genreMap: [Int: String]) throws -> Movie<ImageType> {
        fatalError()
    }
    
    func getGenreMap(from response: UnparsedData) throws -> [Int: String] {
        fatalError()
    }
}
