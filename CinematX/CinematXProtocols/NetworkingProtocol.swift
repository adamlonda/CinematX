//
//  NetworkingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

protocol NetworkingProtocol {
    associatedtype ImageType
    func getJson(url: String, completion: @escaping (Result<[String: Any]>) -> Void)
    func getImage(url: String, completion: @escaping (Result<ImageType>) -> Void)
}

class NetworkingWith<ImageType>: NetworkingProtocol {
    func getJson(url: String, completion: @escaping (Result<[String : Any]>) -> Void) {
        fatalError()
    }
    
    func getImage(url: String, completion: @escaping (Result<ImageType>) -> Void) {
        fatalError()
    }
}
