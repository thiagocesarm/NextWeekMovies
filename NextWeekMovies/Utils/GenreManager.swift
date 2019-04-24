//
//  GenreManager.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

class GenreManager {
    static let shared = GenreManager()
    private var genresDic: [Int:String] = [:]
    
    func loadGenres() {
        TMDBClient().getGenresList() { (result) in
            switch result {
            case .success(let genresFetchResult):
                guard let genresResult = genresFetchResult?.genres else {return}
                for genre in genresResult {
                    self.genresDic[genre.id] = genre.name
                }
            case .failure(let apiError):
                print("[TMDBClient] Error loading genres list: \(apiError.localizedDescription)")
            }
        }
    }
    
    func getGenre(withId id: Int) -> String? {
        return genresDic[id]
    }
    
    func getGenreList(withIds idList: [Int]) -> [String] {
        
        var genres: [String] = []
        for genreId in idList {
            if let genreName = genresDic[genreId] {
                genres.append(genreName)
            }
        }
        
        return genres
    }
}
