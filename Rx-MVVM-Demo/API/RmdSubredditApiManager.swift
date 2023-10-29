//
//  RmdSubredditApiManager.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/10/28.
//

import Foundation
import RxSwift

final class RmdSubredditApiManager {
    private let apimanager: RmdApiManagerProtocol
    
    init(apimanager: RmdApiManagerProtocol = RmdApiManager()) {
        self.apimanager = apimanager
    }
    
    func fetch() -> Observable<Subreddit> {
        return apimanager.dispatch(path: "/subreddits/default.json", parameters: nil)
            .map({ Subreddit(JSON: $0) ?? Subreddit() })
            .asObservable()
            .retry(2)
    }        
}
