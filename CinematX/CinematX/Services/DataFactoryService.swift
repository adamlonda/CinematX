//
//  ParsingService.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

class DataFactoryService: DataFactory<[String: Any]> {
    override func getMovieInfo(from response: [String: Any]) throws -> MovieInfo {
        if let title = response["title"], let overview = response["overview"], let posterPath = response["poster_path"] {
            return MovieInfo(
                title: title as! String,
                overview: overview as! String,
                posterPath: posterPath as! String
            )
        }
        throw CommonError.parsingError
    }
}
