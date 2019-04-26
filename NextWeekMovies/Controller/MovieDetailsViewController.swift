//
//  MovieDetailsViewController.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 25/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var movieBackdropImageView: UIImageView!
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var labelsView: UIView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieGenresLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    
    var movieViewModel: MovieViewModel!
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovieImages()
        movieTitleLabel.text = movieViewModel.title
        movieGenresLabel.text = movieViewModel.genres
        movieReleaseDateLabel.text = movieViewModel.releaseDate
        movieDescriptionLabel.text = movieViewModel.description
    }
    
    // MARK: - Helper methods
    
    private func loadMovieImages() {
        if movieViewModel.hasBackdropURL {
            movieBackdropImageView.kf.indicatorType = .activity
            movieBackdropImageView.kf.setImage(with: movieViewModel.backdropURL) { result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    print(error)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let reloadAction = UIAlertAction(title: "Retry", style: .default, handler: { (_) in
                        self.loadMovieImages()
                    })
                    self.showAlert(withTitle: "Oops...", message: "Could not load backdrop image. Please, try again.", actions: [cancelAction, reloadAction])
                }
            }
        } else {
            movieBackdropImageView.removeFromSuperview()
        }
        
        if movieViewModel.hasPosterURL {
            moviePosterImageView.kf.indicatorType = .activity
            moviePosterImageView.kf.setImage(with: movieViewModel.posterURL)
        } else {
            moviePosterImageView.image = UIImage(named: "noImageAvailable")
        }
    }
}
