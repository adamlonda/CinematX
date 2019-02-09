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
    
    override func getMovieInfo(from response: [String: Any]) throws -> MovieInfo {
        if let title = response["title"],
            let overview = response["overview"],
            let posterPath = response["poster_path"],
            let releaseDate = response["release_date"] {
            
            return MovieInfo(
                title: title as! String,
                overview: overview as! String,
                posterPath: posterPath as! String,
                releaseDate: releaseDate as! String
            )
        }
        throw CommonError.parsingError
    }
    
    override func getMovie(from info: MovieInfo, with poster: UIImage) throws -> Movie<UIImage> {
        if let date = formatter.date(from: info.releaseDate) {
            return Movie(info: info, poster: poster, releaseDate: date)
        }
        throw CommonError.parsingError
    }
}
