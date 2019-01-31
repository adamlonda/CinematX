//
//  NetworkingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

protocol NetworkingProtocol {
    associatedtype ResponseType
    func get(url: String, completion: @escaping (Result<ResponseType>) -> Void)
}

class NetworkingWithResult<T>: NetworkingProtocol {
    typealias ResponseType = T
    
    func get(url: String, completion: @escaping (Result<T>) -> Void) {
        fatalError()
    }
}
