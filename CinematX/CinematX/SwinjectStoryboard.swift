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
        let swinject = defaultContainer
        
        swinject.register(NetworkingProtocol.self) {
            _ in NetworkingService()
        }
        
        swinject.storyboardInitCompleted(PopularMoviesViewController.self) { r, c in
            c.network = r.resolve(NetworkingProtocol.self)
        }
    }
}
