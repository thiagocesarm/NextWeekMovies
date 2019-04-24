//
//  Endpoint.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

struct Endpoint {
    private let path: String
    private var queryItems: [URLQueryItem] = [
        URLQueryItem(name: "api_key", value: TMDBConstants.API_KEY)
    ]
    
    init(path: String, queryParams: [String:String]? = nil) {
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
        components.host = TMDBConstants.HOST
        components.path = TMDBConstants.API_VERSION + path
        components.queryItems = queryItems
        
        return components.url
    }
}
