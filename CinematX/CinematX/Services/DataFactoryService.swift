//
//  ParsingService.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class DataFactoryService: DataFactory<[String: Any], UIImage> {
    private let formatter: DateFormatter
    
    override init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    override func getMovieData(from response: [String: Any]) throws -> MovieData {
        guard let title = response["title"],
            let overview = response["overview"],
            let posterPath = response["poster_path"],
            let releaseDate = response["release_date"],
            let genreIds = response["genre_ids"] else {
            throw CommonError.parsingError
        }
            
        return MovieData(
            title: title as! String,
            overview: overview as! String,
            posterPath: posterPath as! String,
            releaseDate: releaseDate as! String,
            genreIds: genreIds as! [Int])
    }
    
    override func getMovie(from data: MovieData, with poster: UIImage, genreMap: [Int: String]) throws -> Movie<UIImage> {
        guard let date = formatter.date(from: data.releaseDate) else {
            throw CommonError.parsingError
        }
        
        return Movie(
            title: data.title,
            overview: data.overview,
            poster: poster,
            releaseDate: date,
            genres: try data.genreIds.map({ genreId in
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
