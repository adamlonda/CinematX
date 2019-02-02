//
//  NetworkingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Microfutures

protocol NetworkingProtocol {
    associatedtype ImageType
    func getJson(url: String) -> Future<[String: Any]>
    func getImage(url: String) -> Future<ImageType>
}

class NetworkingWith<ImageType>: NetworkingProtocol {
    func getJson(url: String) -> Future<[String: Any]> {
        fatalError()
    }
    
    func getImage(url: String) -> Future<ImageType> {
        fatalError()
    }
}
