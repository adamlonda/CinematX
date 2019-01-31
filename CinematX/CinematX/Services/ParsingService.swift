//
//  ParsingService.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

class ParsingService: Parser<[String: Any]> {
    override func getPopularMovies(from: [String: Any]) -> [MovieItem] {
        let results = from["results"] as! [[String : Any]]
        
        return results.map({ (result: [String: Any]) in
            MovieItem(
                title: result["title"] as! String,
                overview: result["overview"] as! String
            )
        })
    }
}
