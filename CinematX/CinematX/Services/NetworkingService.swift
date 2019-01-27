//
//  NetworkingService.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

class NetworkingService: NetworkingProtocol {
    func get<T>(url: String) -> T {
        return [MovieItem(title: "Movie title goes here")] as! T;
    }
}
