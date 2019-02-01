//
//  TheMovieDatabaseService.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

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
    private func getMoviePoster(path: String, completion: @escaping (Result<ImageType>) -> Void) {
        let url = "\(baseImgUrl)\(imageDim)\(path)"
        network.getImage(url: url, completion: { result in
            switch result {
            case .Success(let image):
                completion(Result{return image})
            case .Failure(let error):
                completion(Result{throw error})
            }
        })
    }
    
    // https://developers.themoviedb.org/3/movies/get-popular-movies
    override func getPopularMovies(languageCode: String, completion: @escaping (Result<[MovieItem]>) -> Void) {
        let url = "\(baseApiUrl)/movie/popular?api_key=\(apiKey)&language=\(languageCode)"
        network.getJson(url: url, completion: { result in
            switch result {
            case .Success(let jsonData):
                completion(Result{return self.parser.getPopularMovies(from: jsonData)})
            case .Failure(let error):
                completion(Result{throw error})
            }
        })
    }
}
