//
//  ParsingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

protocol DataFactoryProtocol {
    associatedtype UnparsedData
    
    func getMovieDataModel(from response: UnparsedData) throws -> MovieDataModel
    func getMovieViewModel(from dataModel: MovieDataModel, with poster: UIImage, genreMap: [Int: String]) throws -> MovieViewModel
    func getGenreMap(from response: UnparsedData) throws -> [Int: String]
}

class DataFactory<UnparsedDataType>: DataFactoryProtocol {
    typealias UnparsedData = UnparsedDataType
    
    func getMovieDataModel(from response: UnparsedData) throws -> MovieDataModel {
        fatalError()
    }
    
    func getMovieViewModel(from dataModel: MovieDataModel, with poster: UIImage, genreMap: [Int: String]) throws -> MovieViewModel {
        fatalError()
    }
    
    func getGenreMap(from response: UnparsedData) throws -> [Int: String] {
        fatalError()
    }
}
