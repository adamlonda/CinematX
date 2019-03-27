//
//  NetworkingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import RxSwift
import UIKit

protocol NetworkingProtocol {
    associatedtype ResponseType
    func getJson(from url: String) -> Observable<ResponseType>
    func getImage(from url: String) -> Observable<UIImage>
}

class Networking<ResponseImplementation>: NetworkingProtocol {
    typealias ResponseType = ResponseImplementation
    
    func getJson(from url: String) -> Observable<ResponseType> {
        fatalError()
    }
    
    func getImage(from url: String) -> Observable<UIImage> {
        fatalError()
    }
}
