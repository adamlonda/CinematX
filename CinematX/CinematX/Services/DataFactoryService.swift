//
//  ParsingService.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class DataFactoryService: DataFactory<[String: Any]> {
    private let formatter: DateFormatter
    
    override init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    override func getMovieItemDataModel(from response: [String: Any]) throws -> MovieItemDataModel {
        guard let title = response["title"],
            let overview = response["overview"],
            let posterPath = response["poster_path"],
            let releaseDate = response["release_date"],
            let genreIds = response["genre_ids"] else {
            throw CommonError.parsingError
        }
            
        return MovieItemDataModel(
            title: title as! String,
            overview: overview as! String,
            posterPath: posterPath as! String,
            releaseDate: releaseDate as! String,
            genreIds: genreIds as! [Int])
    }
    
    override func getMovieItemViewModel(from dataModel: MovieItemDataModel, with poster: UIImage, genreMap: [Int: String]) throws -> MovieItemViewModel {
        guard let date = formatter.date(from: dataModel.releaseDate) else {
            throw CommonError.parsingError
        }
        
        return MovieItemViewModel(
            title: dataModel.title,
            overview: dataModel.overview,
            poster: poster,
            releaseDate: date,
            genres: try dataModel.genreIds.map({ genreId in
                guard let genre = genreMap[genreId] else {
                    throw CommonError.parsingError
                }
                return genre
            }))
    }
    
    override func getGenreMap(from response: [String: Any]) throws -> [Int: String] {
        guard let genres = response["genres"] else {
            throw CommonError.parsingError
        }
        
        return try (genres as! [[String: Any]]).reduce(into: [Int: String]()) {
            guard let id = $1["id"], let name = $1["name"] else {
                throw CommonError.parsingError
            }
            $0[id as! Int] = (name as! String)
        }
    }
}
