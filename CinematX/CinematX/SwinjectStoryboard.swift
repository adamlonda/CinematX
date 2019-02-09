//
//  SwinjectStoryboard.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup () {
        typealias JsonResponse = [String: Any]
        typealias ImageType = UIImage
        
        let swinject = defaultContainer
        
        swinject.register(NetworkingWith<ImageType>.self) {
            _ in NetworkingService()
        }
        
        swinject.register(DataFactory<JsonResponse, ImageType>.self) {
            _ in DataFactoryService()
        }
        
        swinject.register(MovieDatabaseWith<ImageType>.self) {
            r in TheMovieDatabaseService(
                network: r.resolve(NetworkingWith<ImageType>.self)!,
                dataFactory: r.resolve(DataFactory<JsonResponse, ImageType>.self)!)
        }
        
        swinject.storyboardInitCompleted(PopularMoviesViewController.self) { r, c in
            c.movieDb = r.resolve(MovieDatabaseWith<ImageType>.self)
        }
    }
}
