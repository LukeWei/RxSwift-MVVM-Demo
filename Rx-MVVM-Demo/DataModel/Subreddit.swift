//
//  Subreddit.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/10/28.
//

import Foundation
import ObjectMapper

struct Subreddit: Mappable {
    var data: SubredditData = SubredditData()
    
    init?(map: Map) {}
    
    init() {}
    
    mutating func mapping(map: Map) {
        data <- map["data"]
    }
}

struct SubredditData: Mappable {
    var after: String = ""
    var childrens: [SubredditChildren] = []
    
    init?(map: Map) {}
    
    init() {}
    
    mutating func mapping(map: Map) {
        after <- map["after"]
        childrens <- map["children"]
    }
}

struct SubredditChildren: Mappable {
    
    var displayName: String = ""
    var title: String = ""
    var thumbnail: String = ""
    var subreddit: String = ""
    var id: String = ""
    
    init?(map: Map) {}
    
    init() {}
    
    mutating func mapping(map: Map) {
        displayName <- map["data.display_name"]
        title <- map["data.title"]
        thumbnail <- map["data.thumbnail"]
        subreddit <- map["data.subreddit"]
        id <- map["data.id"]
    }
    
    
}
