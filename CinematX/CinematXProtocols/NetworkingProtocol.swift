//
//  NetworkingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Foundation

protocol NetworkingProtocol {
    func getJson(url: String, completion: @escaping (Result<[String: Any]>) -> Void)
    func getImage<OfImageType>(url: String, completion: @escaping (Result<OfImageType>) -> Void)
}
