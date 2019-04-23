//
//  MoviesFetchResult.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

struct MoviesFetchResult: Codable {
    let results: [Movie]
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
