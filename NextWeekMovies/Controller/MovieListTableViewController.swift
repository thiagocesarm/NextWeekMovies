//
//  MovieListTableViewController.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    private var movies: [MovieViewModel] = []
    private let client = TMDBClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        client.getUpcomingMoviesList(onPage: 1, completion: { (result) in
            switch result {
            case .success(let moviesFetchResult):
                guard let moviesResult = moviesFetchResult?.results else {
                    return
                }
                self.movies = moviesResult.map{ MovieViewModel(movie: $0) }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let apiError):
                print("[TMDBClient] Error fetching upcoming movies list: \(apiError.localizedDescription)")
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("Could not cast reusable cell with identifier 'MovieTableViewCell' to MovieTableViewCell type")
        }
        
        cell.movieViewModel = movies[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
