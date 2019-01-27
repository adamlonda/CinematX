//
//  TheMovieDatabaseService.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

class TheMovieDatabaseService: MovieDatabaseProtocol {
    private let network: NetworkingProtocol
    
    required init(network: NetworkingProtocol) {
        self.network = network
    }
    
    func getPopularMovies() -> [MovieItem] {
        return network.get(url: "http://popular-movies.url")
    }
}
