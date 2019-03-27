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
    
    // https://developers.themoviedb.org/3/configuration/get-api-configuration
    private func getMoviePoster(from path: String) -> Observable<UIImage> {
        let url = "\(self.baseImgUrl)\(self.imageDim)\(path)"
        return self.network.getImage(from: url)
    }
    
    private func getMovieData(from response: JsonResponse) -> Observable<MovieDataModel> {
        return Observable<MovieDataModel>.create { (observer) -> Disposable in
            do {
                guard let results = response["results"] else {
                    throw CommonError.parsingError
                }
                
                for result in results as! [JsonResponse] {
                    observer.onNext(try self.dataFactory.getMovieDataModel(from: result))
                }
            } catch {
                observer.onError(error)
            }
            
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    // https://developers.themoviedb.org/3/genres/get-movie-list
    private func getRawResponseAndGenreMap(with languageCode: String) -> Observable<([String: Any], [Int: String])> {
        let popularMoviesUrl = "\(self.baseApiUrl)/movie/popular?api_key=\(self.apiKey)&language=\(languageCode)"
        let genreMapUrl = "\(self.baseApiUrl)/genre/movie/list?api_key=\(self.apiKey)&language=\(languageCode)"
        
        let rawResponseStream = self.network.getJson(from: popularMoviesUrl)
        let genreMapStream = self.network.getJson(from: genreMapUrl)
            .map({ json in
                try self.dataFactory.getGenreMap(from: json)
            })
        
        return Observable.zip(rawResponseStream, genreMapStream, resultSelector: { rawResponse, genreMap in
            return (rawResponse, genreMap)
        })
    }
    
    // https://developers.themoviedb.org/3/movies/get-popular-movies
    func getPopularMovies(with languageCode: String) -> Observable<MovieViewModel> {
        return Observable<MovieViewModel>.create { (observer) -> Disposable in
            _ = self.getRawResponseAndGenreMap(with: languageCode).subscribe(onNext: { resultPackage in
                let rawResponse = resultPackage.0
                let genreMap = resultPackage.1
                
                _ = self.getMovieData(from: rawResponse).subscribe(
                    onNext: { movieData in
                        _ = self.getMoviePoster(from: movieData.posterPath).subscribe(onNext: { moviePoster in
                            do {
                                let movie = try self.dataFactory.getMovieViewModel(from: movieData, with: moviePoster, genreMap: genreMap)
                                observer.onNext(movie)
                            } catch {
                                observer.onError(error)
                            }
                        })
                },
                    onError: { error in
                        observer.onError(error)
                })
            })
            
            return Disposables.create()
        }
    }
}
