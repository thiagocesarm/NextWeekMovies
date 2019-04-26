//
//  TMDBClient.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

class TMDBClient {
    
    // MARK: - Private properties
    
    private let apiRequestsQueue = DispatchQueue(label: "apiRequests")
    
    // MARK: - Initializers
    
    init() {
        if !GenreManager.shared.genresLoaded {
            GenreManager.shared.loadGenres()
        }
    }
    
    // MARK: - Public methods
    
    func resetCache(andExecute completion: @escaping () -> Void) {
        URLSession.shared.reset {
            completion()
        }
    }
    
    func getGenresList(completion: @escaping (Result<GenresFetchResult?, APIError>) -> Void ) {
        let genreService = TMDBServices.getGenresList
        guard let url = genreService.url else {
            preconditionFailure("Failed to construct URL")
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            self.apiRequestsQueue.async {
                if let _ = error {
                    completion(Result.failure(.apiRequestFailure))
                } else {
                    do {
                        let genresResult = try JSONDecoder().decode(GenresFetchResult.self, from: data!)
                        completion(Result.success(genresResult))
                    } catch _ {
                        completion(Result.failure(.jsonDecodingError))
                    }
                }
            }
        }
        task.resume()
    }
    
    func getUpcomingMoviesList(onPage page: Int, completion: @escaping (Result<MoviesFetchResult?, APIError>) -> Void) {
        
        let upcomingMoviesService = TMDBServices.getUpcomingMovies(page: page)
        guard let url = upcomingMoviesService.url else {
            preconditionFailure("Failed to construct URL")
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            self.apiRequestsQueue.async {
                if let _ = error {
                    completion(Result.failure(.apiRequestFailure))
                } else {
                    do {
                        let upcomingMoviesResult = try JSONDecoder().decode(MoviesFetchResult.self, from: data!)
                        completion(Result.success(upcomingMoviesResult))
                    } catch _ {
                        completion(Result.failure(.jsonDecodingError))
                    }
                }
            }
        }
        task.resume()
    }
}
