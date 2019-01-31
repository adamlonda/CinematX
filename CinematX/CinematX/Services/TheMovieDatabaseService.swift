//
//  TheMovieDatabaseService.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

class TheMovieDatabaseService: MovieDatabaseProtocol {
    typealias NetResponse = [String: Any]
    
    private let network: NetworkingWithResult<NetResponse>
    private let parser: Parser<NetResponse>
    
    private let baseUrl: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "40a81d1f384835eaee99ce0f3f6f1e7b"
    
    required init(network: NetworkingWithResult<NetResponse>, parser: Parser<NetResponse>) {
        self.network = network
        self.parser = parser
    }
    
    // https://developers.themoviedb.org/3/movies/get-popular-movies
    func getPopularMovies(completion: @escaping (Result<[MovieItem]>) -> Void) {
        network.get(url: "\(baseUrl)/movie/popular?api_key=\(apiKey)", completion: { result in
            switch result {
            case .Success(let jsonData):
                completion(Result{return self.parser.getPopularMovies(from: jsonData)})
            case .Failure(let error):
                completion(Result{throw error})
            }
        })
    }
}
