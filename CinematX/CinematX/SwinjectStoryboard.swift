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
        typealias NetResponse = [String: Any]
        
        let swinject = defaultContainer
        
        swinject.register(NetworkingWithResult<NetResponse>.self) {
            _ in NetworkingService()
        }
        
        swinject.register(Parser<NetResponse>.self) {
            _ in ParsingService()
        }
        
        swinject.register(MovieDatabaseProtocol.self) {
            r in TheMovieDatabaseService(
                network: r.resolve(NetworkingWithResult<NetResponse>.self)!,
                parser: r.resolve(Parser<NetResponse>.self)!)
        }
        
        swinject.storyboardInitCompleted(PopularMoviesViewController.self) { r, c in
            c.movieDb = r.resolve(MovieDatabaseProtocol.self)
        }
    }
}
