//
//  MovieViewModel.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 24/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

final class MovieViewModel {
    
    // MARK: - Properties
    
    private let movie: Movie
    private let posterImageWidth = 500
    private let backdropImageWidth = 500
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var posterURL: URL? {
        if let posterPath = movie.posterPath {
            return TMDBServices.getImage(width: posterImageWidth, imagePath: posterPath).url
        }
        return nil
    }
    
    var hasPosterURL: Bool {
        return posterURL != nil
    }
    
    var backdropURL: URL? {
        if let backdropPath = movie.backdropPath {
            return TMDBServices.getImage(width: posterImageWidth, imagePath: backdropPath).url
        }
        return nil
    }
    
    var hasBackdropURL: Bool {
        return backdropURL != nil
    }
    
    var genres: String {
        let movieGenreList = GenreManager.shared.getGenreList(withIds: movie.genreIds)
        if movieGenreList.isEmpty { return "No genres" }
        return movieGenreList.joined(separator: ", ")
    }
    
    var releaseDate: String {
        return movie.releaseDate
    }
    
    var description: String {
        return "\t\(movie.overview)"
    }
    
}
