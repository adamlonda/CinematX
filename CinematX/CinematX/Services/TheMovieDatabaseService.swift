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
    private let dataFactory: DataFactory<JsonResponse, ImageType>
    
    private let baseApiUrl: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "40a81d1f384835eaee99ce0f3f6f1e7b"
    
    private let baseImgUrl: String = "https://image.tmdb.org/t/p/"
    private let imageDim: String = "w500"
    
    required init(network: NetworkingWith<ImageType>, dataFactory: DataFactory<JsonResponse, ImageType>) {
        self.network = network
        self.dataFactory = dataFactory
    }
    
    // https://developers.themoviedb.org/3/configuration/get-api-configuration
    private func getMoviePoster(from path: String) -> Future<ImageType> {
        let url = "\(self.baseImgUrl)\(self.imageDim)\(path)"
        return self.network.getImage(from: url)
    }
    
    override func getMovie(from info: MovieInfo) -> Future<Movie<ImageType>> {
        return self.getMoviePoster(from: info.posterPath)
            .map({ image in
                return try self.dataFactory.getMovie(from: info, with: image)
            })
    }
    
    private func parseMovieInfo(from response: JsonResponse) throws -> [MovieInfo] {
        if let results = response["results"] {
            return try (results as! [JsonResponse]).map({ movieResult in
                try dataFactory.getMovieInfo(from: movieResult)
            })
        }
        throw CommonError.parsingError
    }
    
    // https://developers.themoviedb.org/3/movies/get-popular-movies
    override func getPopularMoviesInfo(with languageCode: String) -> Future<[MovieInfo]> {
        let url = "\(self.baseApiUrl)/movie/popular?api_key=\(self.apiKey)&language=\(languageCode)"
        return self.network.getJson(from: url)
            .map(self.parseMovieInfo)
    }
}
