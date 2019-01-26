//
//  NetworkingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

enum HttpMethod: String {
    case get = "GET"
}

protocol NetworkingProtocol {
    func call(url: String, withMethod: HttpMethod) -> String
}
