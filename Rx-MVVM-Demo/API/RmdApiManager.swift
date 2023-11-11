//
//  RmdApiManager.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/10/28.
//

import Foundation
import Alamofire
import RxSwift

struct ApiConstant {
    static let baseUrlString = "https://www.reddit.com"
}

enum RmdApiError: Error {
    case JsonConvert
}

protocol RmdApiManagerProtocol {
    func dispatch(path: String, parameters: [String: Any]?) -> Observable<[String: Any]>
}

final class RmdApiManager: RmdApiManagerProtocol {
    
    func dispatch(path: String, parameters: [String: Any]? = nil) -> Observable<[String: Any]> {
        
        var urlComponet = URLComponents(string: ApiConstant.baseUrlString)!
        urlComponet.path = path
        return jsonResponse(urlComponet, parameters: parameters)
    }
    
    private func jsonResponse(_ url: URLComponents, parameters: [String: Any]? = nil) -> Observable<[String: Any]> {
        Observable<[String: Any]>.create { observer in
            AF.request(url, method: .get, parameters: parameters)
                .validate()
                .responseData { response in
                    
                    switch response.result {
                    case let .success(value):
                        do {
                            
                            guard let json = try JSONSerialization.jsonObject(with: value) as? [String: Any] else {
                                observer.onError(RmdApiError.JsonConvert)
                                throw RmdApiError.JsonConvert
                            }
                            
                            observer.on(.next(json))
                            observer.on(.completed)
                        } catch let parseError {
                            observer.onError(parseError)
                        }

                    case let .failure(error):
                        observer.on(.error(error))
                    }
                }
            return Disposables.create()
        }
    }
    
}
