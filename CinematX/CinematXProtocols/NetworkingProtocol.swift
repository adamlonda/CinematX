//
//  NetworkingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

protocol NetworkingProtocol {
    func get<T>(url: String) -> T
}
