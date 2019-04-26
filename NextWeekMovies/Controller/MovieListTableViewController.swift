//
//  MovieListTableViewController.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private var currentPage = 1
    private var maxPage = 1
    private var movies: [MovieViewModel] = []
    private let apiClient = TMDBClient()
    private let spinner = LoadingSpinnerViewController()
    private var shouldScrollToTop = false
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startSpinner(onViewController: self)
        fetchMovies(onPage: 1)
    }
    
    // MARK: - Data fetching
    
    private func reloadMovies() {
        currentPage = 1
        maxPage = 1
        movies = []
        spinner.startSpinner(onViewController: self)
        apiClient.resetCache {
            self.fetchMovies(onPage: self.currentPage)
        }
    }
    
    private func getMoviesNextPage() {
        if currentPage >= maxPage {
            return
        }
        currentPage += 1
        fetchMovies(onPage: currentPage)
    }
    
    private func fetchMovies(onPage page: Int) {
        guard page <= maxPage else { return }
        
        apiClient.getUpcomingMoviesList(onPage: page, completion: { (result) in
            switch result {
            case .success(let moviesFetchResult):
                guard let moviesResult = moviesFetchResult?.results,
                    let totalPages = moviesFetchResult?.totalPages else {
                        return
                }
                
                if totalPages > self.maxPage {
                    self.maxPage = totalPages
                }
                
                self.movies += moviesResult.map{ MovieViewModel(movie: $0) }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    if self.shouldScrollToTop {
                        self.shouldScrollToTop = false
                        self.tableView.scrollToTopCell(animated: true)
                    }
                    
                    if self.spinner.isSpinnig {
                        self.spinner.stopSpinner()
                    }
                }
                
            case .failure(let apiError):
                print("[TMDBClient] Error fetching upcoming movies list: \(apiError.localizedDescription)")
                
                let reloadAction = UIAlertAction(title: "Reload entire list", style: .default, handler: { _ in
                    self.shouldScrollToTop = true
                    self.reloadMovies()
                })
                
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    self.shouldScrollToTop = false
                    self.fetchMovies(onPage: self.currentPage)
                })
                
                DispatchQueue.main.async {
                    self.showAlert(withTitle: "Ops...", message: "It was not possible to fetch movie list from the internet. Please, try again.", actions: [reloadAction, retryAction])
                }
            }
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentPage < maxPage) ? movies.count + 1 : movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < movies.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
                fatalError("Could not cast reusable cell with identifier 'MovieTableViewCell' to MovieTableViewCell type")
            }
            
            cell.movieViewModel = movies[indexPath.row]
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as? LoadingTableViewCell else {
                fatalError("Could not cast reusable cell with identifier 'LoadingTableViewCell' to LoadingTableViewCell type")
            }
            cell.startActivityIndicator()
            getMoviesNextPage()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.row < movies.count) ? 220 : 45
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < movies.count {
            performSegue(withIdentifier: "moviesListToMovieDetail", sender: movies[indexPath.row])
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moviesListToMovieDetail" {
            guard let movieViewModel = sender as? MovieViewModel,
                let movieDetailsViewController = segue.destination as? MovieDetailsViewController else {
                return
            }

            movieDetailsViewController.movieViewModel = movieViewModel
            
            let backBarButtonItem = UIBarButtonItem()
            backBarButtonItem.title = "Back"
            navigationItem.backBarButtonItem = backBarButtonItem
        }
    }
}
