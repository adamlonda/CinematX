//
//  TheMovieDatabaseService.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import RxSwift
import UIKit

class TheMovieDatabaseService: MovieDatabaseProtocol {
    typealias JsonResponse = [String: Any]
    
    private let network: Networking<JsonResponse>
    private let dataFactory: DataFactory<JsonResponse>
    
    private let baseApiUrl: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "40a81d1f384835eaee99ce0f3f6f1e7b"
    
    private let baseImgUrl: String = "https://image.tmdb.org/t/p/"
    private let imageDim: String = "w500"
    
    required init(network: Networking<JsonResponse>, dataFactory: DataFactory<JsonResponse>) {
        self.network = network
        self.dataFactory = dataFactory
    }
    
    func isOnline() -> Bool {
        return network.isNetworkAvailable()
    }
    
    // https://developers.themoviedb.org/3/configuration/get-api-configuration
    private func getMoviePoster(from model: MovieItemDataModel) -> Observable<(MovieItemDataModel, UIImage)> {
        let url = "\(self.baseImgUrl)\(self.imageDim)\(model.posterPath)"
        return self.network.getImage(from: url)
            .map({ image in (model, image) })
    }
    
    private func getMovieItemsData(from response: JsonResponse) -> Observable<MovieItemDataModel> {
        return Observable<MovieItemDataModel>.create { (observer) -> Disposable in
            do {
                guard let results = response["results"] else {
                    throw CommonError.parsingError
                }
                
                for result in results as! [JsonResponse] {
                    observer.onNext(try self.dataFactory.getMovieItemDataModel(from: result))
                }
            } catch {
                observer.onError(error)
            }
            
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    // https://developers.themoviedb.org/3/movies/get-popular-movies
    func getPopularMovies(with languageCode: String) -> Observable<MovieItemViewModel> {
        let popularMoviesUrl = "\(self.baseApiUrl)/movie/popular?api_key=\(self.apiKey)&language=\(languageCode)"
        return self.network.getJson(from: popularMoviesUrl)
            .flatMap({ response in self.getMovieItemsData(from: response) })
            .flatMap({ model in self.getMoviePoster(from: model) })
            .map({ posteredModel in try self.dataFactory.getMovieItemViewModel(from: posteredModel.0, with: posteredModel.1) })
    }
}
