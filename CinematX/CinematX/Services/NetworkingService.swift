//
//  NetworkingService.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Alamofire
import AlamofireImage

enum NetworkingServiceError: Error {
    case unexpectedResponse
}

class NetworkingService: NetworkingProtocol {
    // Inspired by
    // https://gist.github.com/cmoulton/9591be2b10043e6811a845f6dcbe821a#file-simple-alamofire-calls-in-swift-4
    // https://medium.com/@shenghuawu/simple-ios-api-client-with-alamofire-cfb2cadf6c11
    private func handleResponse<In, Out>(withCompletion: (Result<Out>) -> Void, response: DataResponse<In>) {
        guard response.result.error == nil else {
            withCompletion(Result{ throw response.result.error! })
            return
        }
        
        guard let data = response.result.value else {
            withCompletion(Result{ throw NetworkingServiceError.unexpectedResponse })
            return
        }
        
        withCompletion(Result{return data as! Out})
    }
    
    func getJson(url: String, completion: @escaping (Result<[String: Any]>) -> Void) {
        Alamofire.request(url)
            .responseJSON { response in
                self.handleResponse(withCompletion: completion, response: response)
        }
    }
    
    func getImage<OfImageType>(url: String, completion: @escaping (Result<OfImageType>) -> Void) {
        Alamofire.request(url)
            .responseImage { response in
                self.handleResponse(withCompletion: completion, response: response)
        }
    }
}
