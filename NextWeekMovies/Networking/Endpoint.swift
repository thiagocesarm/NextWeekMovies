//
//  Endpoint.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

struct Endpoint {
    private let host: String
    private let path: String
    private var queryItems: [URLQueryItem] = []
    
    init(host: String, path: String, queryParams: [String:String]? = nil) {
        self.host = host
        self.path = path
        if queryParams != nil {
            addQueryItems(queryParams!)
        }
    }
}

extension Endpoint {
    mutating func addQueryItems(_ newQueryItems: [String:String]) {
        for (key, value) in newQueryItems {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        return components.url
    }
}
