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

protocol RmdApiManagerProtocol {
    func dispatch(path: String, parameters: [String: Any]?) -> Observable<Data>
}

final class RmdApiManager: RmdApiManagerProtocol {
    
    func dispatch(path: String, parameters: [String : Any]? = nil) -> Observable<Data> {
        
        let url = URL(string: ApiConstant.baseUrlString)!.appendingPathComponent(path)
        
        return Observable<Data>.create { observer in
            AF.request(url, method: .get, parameters: parameters)
                .validate()
                .responseData { response in
                    print("response: \(response)")
                    
                    switch response.result {
                    case let .success(value):
                        do {
                            try JSONSerialization.jsonObject(with: value)
                            observer.on(.next(value))
                            observer.on(.completed)
                        } catch let parseError {
                            observer.on(.error(parseError))
                        }

                    case let .failure(error):
                        observer.on(.error(error))
                    }
                }
            return Disposables.create()
        }
    }
    
}
