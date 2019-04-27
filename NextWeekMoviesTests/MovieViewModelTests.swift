//
//  MovieViewModelTests.swift
//  NextWeekMoviesTests
//
//  Created by Thiago Lucena on 26/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//
import XCTest
@testable import NextWeekMovies

class MovieViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        GenreManager.shared.loadGenres()
    }
    
    func testMovieViewModelProperties() {
        let movie = Movie(title: "Test Movie", posterPath: nil, backdropPath: nil, voteAverage: 5.2, genreIds: [28, 12, 878], overview: "This is the overview of a test movie", releaseDate: "2019-01-01")
        let movieViewModel = MovieViewModel(movie: movie)
        
        XCTAssertEqual(movieViewModel.title, "Test Movie")
        XCTAssertEqual(movieViewModel.hasPosterURL, false)
        XCTAssertEqual(movieViewModel.posterURL, nil)
        XCTAssertEqual(movieViewModel.hasBackdropURL, false)
        XCTAssertEqual(movieViewModel.backdropURL, nil)
        XCTAssertEqual(movieViewModel.genres, "Action, Adventure, Science Fiction")
        XCTAssertEqual(movieViewModel.description.trimmingCharacters(in: .whitespacesAndNewlines), "This is the overview of a test movie")
        XCTAssertEqual(movieViewModel.releaseDate, "2019-01-01")
        
        let posterPath = "/or06FN3Dka5tukK1e9sl16pB3iy.jpg"
        let backdropPath = "/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg"
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
        
        let movieWithURLs = Movie(title: "Test Movie", posterPath: posterPath, backdropPath: backdropPath, voteAverage: 5.2, genreIds: [28, 12, 878], overview: "This is the overview of a test movie", releaseDate: "2019-01-01")
        let movieWithURLsViewModel = MovieViewModel(movie: movieWithURLs)
        
        XCTAssertEqual(movieWithURLsViewModel.hasPosterURL, true)
        XCTAssertEqual(movieWithURLsViewModel.posterURL, posterURL)
        XCTAssertEqual(movieWithURLsViewModel.hasBackdropURL, true)
        XCTAssertEqual(movieWithURLsViewModel.backdropURL, backdropURL)
    }
}
