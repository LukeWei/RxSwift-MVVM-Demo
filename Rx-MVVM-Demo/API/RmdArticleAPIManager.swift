//
//  RmdArticleAPIManager.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/5.
//

import Foundation
import Alamofire
import RxSwift

final class RmdArticleAPIManager {
    
    let apiManager: RmdApiManagerProtocol
    
    init(apiManager: RmdApiManagerProtocol = RmdApiManager()) {
        self.apiManager = apiManager
    }
    
    func fetch(subredditDisplayName: String, after: String? = nil) -> Observable<Subreddit> {
        let path = "/r/\(subredditDisplayName)/hot.json"
        var parameters: [String: Any] = [:]
        if let after = after {
            parameters["after"] = after
        }
        return apiManager.dispatch(path: path, parameters: parameters)
            .map({ Subreddit(JSON: $0) ?? Subreddit() })
            .asObservable()
            .retry(2)
    }
}
