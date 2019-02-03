//
//  TheMovieDatabaseService.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Microfutures
import UIKit

class TheMovieDatabaseService: MovieDatabaseWith<UIImage> {
    typealias JsonResponse = [String: Any]
    typealias ImageType = UIImage
    
    private let network: NetworkingWith<ImageType>
    private let parser: Parser<JsonResponse>
    
    private let baseApiUrl: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "40a81d1f384835eaee99ce0f3f6f1e7b"
    
    private let baseImgUrl: String = "https://image.tmdb.org/t/p/"
    private let imageDim: String = "w500"
    
    required init(network: NetworkingWith<ImageType>, parser: Parser<JsonResponse>) {
        self.network = network
        self.parser = parser
    }
    
    // https://developers.themoviedb.org/3/configuration/get-api-configuration
    private func getMoviePoster(path: String) -> Future<ImageType> {
        let url = "\(self.baseImgUrl)\(self.imageDim)\(path)"
        return self.network.getImage(url: url)
    }
    
    private func parsePopularMovies(from: JsonResponse, completion: (Result<[MovieItem]>) -> Void) {
        do {
            let movies = try self.parser.getPopularMovies(from: from)
            completion(.success(movies))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    // https://developers.themoviedb.org/3/movies/get-popular-movies
    override func getPopularMovies(languageCode: String) -> Future<[MovieItem]> {
        return Future<[MovieItem]> { completion in
            let url = "\(self.baseApiUrl)/movie/popular?api_key=\(self.apiKey)&language=\(languageCode)"
            self.network.getJson(url: url)
            .subscribe(
                onNext: { json in
                    self.parsePopularMovies(from: json, completion: completion)
            },
                onError: { error in
                    completion(.failure(error))
            })
        }
    }
}
