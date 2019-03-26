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
        
        let swinject = defaultContainer
        
        swinject.register(NetworkingProtocol.self) {
            _ in NetworkingService()
        }
        
        swinject.register(DataFactory<JsonResponse>.self) {
            _ in DataFactoryService()
        }
        
        swinject.register(MovieDatabaseProtocol.self) {
            r in TheMovieDatabaseService(
                network: r.resolve(NetworkingProtocol.self)!,
                dataFactory: r.resolve(DataFactory<JsonResponse>.self)!)
        }
        
        swinject.storyboardInitCompleted(PopularMoviesViewController.self) { r, c in
            c.movieDb = r.resolve(MovieDatabaseProtocol.self)
        }
    }
}
