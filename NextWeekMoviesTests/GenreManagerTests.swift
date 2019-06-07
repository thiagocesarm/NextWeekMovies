//
//  GenreManagerTests.swift
//  NextWeekMoviesTests
//
//  Created by Thiago Lucena on 26/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import XCTest
@testable import NextWeekMovies

class GenreManagerTests: XCTestCase {
    
    var genresDic: [Int:String] = [:]
    var apiClient = TMDBClient()
    
    override class func setUp() {
        GenreManager.shared.loadGenres()
    }
    
    override func setUp() {
        super.setUp()
        apiClient.getGenresList { (result) in
            switch result {
            case .success(let genresFetchResult):
                guard let genresResult = genresFetchResult?.genres else {return}
                for genre in genresResult {
                    self.genresDic[genre.id] = genre.name
                }
            case .failure(_):
                XCTFail("Could not fetch genres from TMDB API")
            }
        }
    }
    
    func testGetGenre() {
        for (genreId, genreName) in genresDic {
            let genreFromManager = GenreManager.shared.getGenre(withId: genreId)
            XCTAssertNotNil(genreFromManager)
            XCTAssertEqual(genreFromManager, genreName)
        }
    }
    
    func testGetGenreList() {
        var genresIds: [Int] = []
        var genresList: [String] = []
        for (genreId, genreName) in genresDic {
            genresIds.append(genreId)
            genresList.append(genreName)
        }
        
        XCTAssertEqual(GenreManager.shared.getGenreList(withIds: genresIds), genresList)
    }
}
