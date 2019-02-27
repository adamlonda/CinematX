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
    
    func getMovieDataModel(from response: UnparsedData) throws -> MovieDataModel
    func getMovieViewModel(from dataModel: MovieDataModel, with poster: ImageType, genreMap: [Int: String]) throws -> MovieViewModel<ImageType>
    func getGenreMap(from response: UnparsedData) throws -> [Int: String]
}

class DataFactory<FromType, WithImage>: DataFactoryProtocol {
    typealias UnparsedData = FromType
    typealias ImageType = WithImage
    
    func getMovieDataModel(from response: UnparsedData) throws -> MovieDataModel {
        fatalError()
    }
    
    func getMovieViewModel(from dataModel: MovieDataModel, with poster: ImageType, genreMap: [Int: String]) throws -> MovieViewModel<ImageType> {
        fatalError()
    }
    
    func getGenreMap(from response: UnparsedData) throws -> [Int: String] {
        fatalError()
    }
}
