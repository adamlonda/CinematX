//
//  Result.swift
//  CinematX
//
//  Created by Adam Londa on 31/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

enum Result<ValueType> {
    case Success(value: ValueType)
    case Failure(error: Error)
    
    init(_ f: () throws -> ValueType) {
        do {
            let value = try f()
            self = .Success(value: value)
        } catch let error {
            self = .Failure(error: error)
        }
    }
}
