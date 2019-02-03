//
//  ParsingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

protocol DataFactoryProtocol {
    associatedtype UnparsedData
    func getMovieInfo(from response: UnparsedData) throws -> MovieInfo
}

class DataFactory<From>: DataFactoryProtocol {
    typealias UnparsedData = From
    
    func getMovieInfo(from response: UnparsedData) throws -> MovieInfo {
        fatalError()
    }
}
