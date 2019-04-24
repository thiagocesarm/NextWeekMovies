//
//  TMDBApi.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

class TMDBConstants {
    static let HOST = "api.themoviedb.org"
    static let API_VERSION = "/3"
    static let API_KEY = "1f54bd990f1cdfb230adb312546d765d"
}

enum TMDBServices {
    case getUpcomingMovies(page: Int)
    case getGenresList
    
    var url: URL? {
        let path: String
        var queryParams: [String:String] = [:]
        
        switch self {
        case .getUpcomingMovies(let pageNum):
            path = "/movie/upcoming"
            queryParams["page"] = String(pageNum)
        case .getGenresList:
            path = "/genre/movie/list"
        }
        
        let endpoint = Endpoint(path: path, queryParams: queryParams)
        return endpoint.url
    }
}
