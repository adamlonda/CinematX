//
//  NetworkingService.swift
//  CinematX
//
//  Created by Adam Londa on 26/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import Alamofire
import AlamofireImage
//import Microfutures
import RxSwift

enum NetworkingServiceError: Error {
    case emptyResponse
}

// Inspired by
// https://gist.github.com/cmoulton/9591be2b10043e6811a845f6dcbe821a#file-simple-alamofire-calls-in-swift-4
// https://medium.com/ios-os-x-development/managing-async-code-in-swift-d7be44cae89f
class NetworkingService: NetworkingWith<UIImage> {
//    private func handle<In, Out>(response: DataResponse<In>, completion: (Microfutures.Result<Out>) -> Void) {
//        guard response.result.error == nil else {
//            completion(.failure(response.result.error!))
//            return
//        }
//
//        guard let data = response.result.value else {
//            completion(.failure(NetworkingServiceError.emptyResponse))
//            return
//        }
//
//        completion(.success(data as! Out))
//    }
    
//    override func getJson(from url: String) -> Future<[String: Any]> {
//        return Future<[String: Any]> { completion in
//            Alamofire.request(url)
//                .responseJSON { response in
//                    self.handle(response: response, completion: completion)
//            }
//        }
//    }
//
//    override func getImage(from url: String) -> Future<UIImage> {
//        return Future<UIImage> { completion in
//            Alamofire.request(url)
//                .responseImage { response in
//                    self.handle(response: response, completion: completion)
//            }
//        }
//    }
    
    private func handle<In, Out>(response: DataResponse<In>, observer: AnyObserver<Out>) {
        guard response.result.error == nil else {
            observer.onError(response.result.error!)
            return
        }

        guard let data = response.result.value else {
            observer.onError(NetworkingServiceError.emptyResponse)
            return
        }

        observer.onNext(data as! Out)
        observer.onCompleted()
    }
    
    override func getJson(from url: String) -> Observable<[String: Any]> {
        return Observable<[String: Any]>.create { (observer) -> Disposable in
            let request = Alamofire.request(url)
                .responseJSON { response in
                    self.handle(response: response, observer: observer)
            }
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
    
    override func getImage(from url: String) -> Observable<UIImage> {
        return Observable<UIImage>.create { (observer) -> Disposable in
            let request = Alamofire.request(url)
                .responseImage { response in
                    self.handle(response: response, observer: observer)
            }
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
}
