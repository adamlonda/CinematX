//
//  ParsingService.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

enum ParsingServiceError: Error {
    case parsingError
}

class ParsingService: Parser<[String: Any]> {
    override func getPopularMovies(from: [String: Any]) throws -> [MovieItem] {
        if let results = from["results"] {
            return try (results as! [[String: Any]]).map({ (result: [String: Any]) in
                if let title = result["title"], let overview = result["overview"] {
                    return MovieItem(
                        title: title as! String,
                        overview: overview as! String
                    )
                }
                throw ParsingServiceError.parsingError
            })
        }
        throw ParsingServiceError.parsingError
    }
}
