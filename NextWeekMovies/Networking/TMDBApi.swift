//
//  TMDBApi.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

class TMDBConstants {
    static let API_HOST = "api.themoviedb.org"
    static let API_IMAGE_HOST = "image.tmdb.org"
    static let API_VERSION = "/3"
    static let API_KEY = "1f54bd990f1cdfb230adb312546d765d"
}

enum TMDBServices {
    case getUpcomingMovies(page: Int)
    case getGenresList
    case getImage(width: Int, imagePath: String)
    
    var url: URL? {
        var host = TMDBConstants.API_HOST
        var path = TMDBConstants.API_VERSION
        var queryParams: [String:String] = [
            "api_key": TMDBConstants.API_KEY
        ]
        
        switch self {
        case .getUpcomingMovies(let pageNum):
            path = path + "/movie/upcoming"
            queryParams["page"] = String(pageNum)
        case .getGenresList:
            path = path + "/genre/movie/list"
        case .getImage(let width, let imagePath):
            host = TMDBConstants.API_IMAGE_HOST
            path = "/t/p/w\(width)" + imagePath
            queryParams = [:]
        }
        
        let endpoint = Endpoint(host: host, path: path, queryParams: queryParams)
        return endpoint.url
    }
}
