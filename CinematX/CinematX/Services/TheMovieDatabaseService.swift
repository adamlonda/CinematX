//
//  TheMovieDatabaseService.swift
//  CinematX
//
//  Created by Adam Londa on 27/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

//import Microfutures
import RxSwift
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
//    private func getMoviePoster(from path: String) -> Future<ImageType> {
//        let url = "\(self.baseImgUrl)\(self.imageDim)\(path)"
//        return self.network.getImage(from: url)
//    }
    
    // https://developers.themoviedb.org/3/configuration/get-api-configuration
    private func getMoviePoster(from path: String) -> Observable<ImageType> {
        let url = "\(self.baseImgUrl)\(self.imageDim)\(path)"
        return self.network.getImage(from: url)
    }
    
//    override func getMovie(from info: MovieInfo, with genreMap: [Int: String]) -> Future<Movie<ImageType>> {
//        return self.getMoviePoster(from: info.posterPath)
//            .map({ image in
//                return try self.dataFactory.getMovie(from: info, with: image, genreMap: genreMap)
//            })
//    }
    
//    override func getMovie(from info: MovieInfo, with genreMap: [Int: String]) -> Observable<Movie<ImageType>> {
//        return self.getMoviePoster(from: info.posterPath)
//            .map({ image in
//                return try self.dataFactory.getMovie(from: info, with: image, genreMap: genreMap)
//            })
//    }
//
//    private func parseMovieInfo(from response: JsonResponse) throws -> [MovieData] {
//        guard let results = response["results"] else {
//            throw CommonError.parsingError
//        }
//
//        return try (results as! [JsonResponse]).map({ movieResult in
//            try dataFactory.getMovieData(from: movieResult)
//        })
//    }
    
    private func getMovieData(from response: JsonResponse) -> Observable<MovieData> {
        return Observable<MovieData>.create { (observer) -> Disposable in
            do {
                guard let results = response["results"] else {
                    throw CommonError.parsingError
                }
                
                for result in results as! [JsonResponse] {
                    observer.onNext(try self.dataFactory.getMovieData(from: result))
                }
            } catch {
                observer.onError(error)
            }
            
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    // https://developers.themoviedb.org/3/movies/get-popular-movies
//    override func getPopularMoviesInfo(with languageCode: String) -> Future<[MovieInfo]> {
//        let url = "\(self.baseApiUrl)/movie/popular?api_key=\(self.apiKey)&language=\(languageCode)"
//        return self.network.getJson(from: url)
//            .map(self.parseMovieInfo)
//    }
    
    // https://developers.themoviedb.org/3/movies/get-popular-movies
//    override func getPopularMoviesInfo(with languageCode: String) -> Observable<[MovieInfo]> {
//        let url = "\(self.baseApiUrl)/movie/popular?api_key=\(self.apiKey)&language=\(languageCode)"
//        return self.network.getJson(from: url)
//            .map(self.parseMovieInfo)
//    }
    
    // https://developers.themoviedb.org/3/genres/get-movie-list
//    override func getGenreMap(with languageCode: String) -> Future<[Int: String]> {
//        let url = "\(self.baseApiUrl)/genre/movie/list?api_key=\(self.apiKey)&language=\(languageCode)"
//        return self.network.getJson(from: url)
//            .map(dataFactory.getGenreMap)
//    }
    
    // https://developers.themoviedb.org/3/genres/get-movie-list
//    override func getGenreMap(with languageCode: String) -> Observable<[Int: String]> {
//        let url = "\(self.baseApiUrl)/genre/movie/list?api_key=\(self.apiKey)&language=\(languageCode)"
//        return self.network.getJson(from: url)
//            .map(dataFactory.getGenreMap)
//    }
    
    override func getPopularMovies(with languageCode: String) -> Observable<Movie<ImageType>> {
        return Observable<Movie<ImageType>>.create { (observer) -> Disposable in
            let popularMoviesUrl = "\(self.baseApiUrl)/movie/popular?api_key=\(self.apiKey)&language=\(languageCode)"
            let moviesResponseStream = self.network.getJson(from: popularMoviesUrl)
            
            let genreMapUrl = "\(self.baseApiUrl)/genre/movie/list?api_key=\(self.apiKey)&language=\(languageCode)"
            let genreMapStream = self.network.getJson(from: genreMapUrl)
                .map({ json in try self.dataFactory.getGenreMap(from: json) })
            
            Observable.zip(moviesResponseStream, genreMapStream, resultSelector: { movieResponse, genreMap in
                self.getMovieData(from: movieResponse).subscribe(onNext: { movieData in
                    self.getMoviePoster(from: movieData.posterPath).subscribe(onNext: { moviePoster in
                        do {
                            let movie = try self.dataFactory.getMovie(from: movieData, with: moviePoster, genreMap: genreMap)
                            observer.onNext(movie)
                        } catch {
                            observer.onError(error)
                        }
                    })
                })
            })
            
            return Disposables.create()
        }
    }
}
