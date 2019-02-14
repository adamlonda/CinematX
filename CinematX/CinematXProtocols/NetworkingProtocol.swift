//
//  NetworkingProtocol.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

//import Microfutures
import RxSwift

protocol NetworkingProtocol {
    associatedtype ImageType
//    func getJson(from url: String) -> Future<[String: Any]>
//    func getImage(from url: String) -> Future<ImageType>
    func getJson(from url: String) -> Observable<[String: Any]>
    func getImage(from url: String) -> Observable<ImageType>
}

class NetworkingWith<ImageType>: NetworkingProtocol {
//    func getJson(from url: String) -> Future<[String: Any]> {
//        fatalError()
//    }
//    
//    func getImage(from url: String) -> Future<ImageType> {
//        fatalError()
//    }
    
    func getJson(from url: String) -> Observable<[String: Any]> {
        fatalError()
    }
    
    func getImage(from url: String) -> Observable<ImageType> {
        fatalError()
    }
}
