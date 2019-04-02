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
    
    func getMovieItemDataModel(from response: UnparsedData) throws -> MovieItemDataModel
    func getMovieItemViewModel(from dataModel: MovieItemDataModel, with poster: UIImage, genreMap: [Int: String]) throws -> MovieItemViewModel
    func getGenreMap(from response: UnparsedData) throws -> [Int: String]
}

class DataFactory<UnparsedDataType>: DataFactoryProtocol {
    typealias UnparsedData = UnparsedDataType
    
    func getMovieItemDataModel(from response: UnparsedData) throws -> MovieItemDataModel {
        fatalError()
    }
    
    func getMovieItemViewModel(from dataModel: MovieItemDataModel, with poster: UIImage, genreMap: [Int: String]) throws -> MovieItemViewModel {
        fatalError()
    }
    
    func getGenreMap(from response: UnparsedData) throws -> [Int: String] {
        fatalError()
    }
}
