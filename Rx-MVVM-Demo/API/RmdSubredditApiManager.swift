//
//  RmdSubredditApiManager.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/10/28.
//

import Foundation

class RmdSubredditApiManager {
    private let apimanager: RmdApiManagerProtocol
    
    init(apimanager: RmdApiManagerProtocol = RmdApiManager()) {
        self.apimanager = apimanager
    }
        
}
