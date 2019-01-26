//
//  NetworkingService.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

class NetworkingService: NetworkingProtocol {
    func call(url: String, withMethod: HttpMethod) -> String {
        return "\(withMethod.rawValue) response goes here."
    }
}
