//
//  Movie.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let genreIds: [Int]
    let overview: String
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
        case overview
        case releaseDate = "release_date"
    }
}
