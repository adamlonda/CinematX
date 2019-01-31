//
//  NetworkingService.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Alamofire

enum NetworkingServiceError: Error {
    case unexpectedResponse
}

class NetworkingService: NetworkingWithResult<[String: Any]> {
    // Inspired by
    // https://gist.github.com/cmoulton/9591be2b10043e6811a845f6dcbe821a#file-simple-alamofire-calls-in-swift-4
    // https://medium.com/@shenghuawu/simple-ios-api-client-with-alamofire-cfb2cadf6c11
    override func get(url: String, completion: @escaping (Result<[String: Any]>) -> Void) {
        Alamofire.request(url)
            .responseJSON { response in
                guard response.result.error == nil else {
                    completion(Result{ throw response.result.error! })
                    return
                }
                
                guard let json = response.result.value as? [String: Any] else {
                    if let error = response.result.error {
                        completion(Result{ throw error })
                        return
                    }
                    
                    completion(Result{ throw NetworkingServiceError.unexpectedResponse })
                    return
                }
                
                completion(Result{return json})
        }
    }
}
