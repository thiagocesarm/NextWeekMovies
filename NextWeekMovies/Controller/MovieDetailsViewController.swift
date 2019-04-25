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
        
        if movieViewModel.hasBackdropURL {
            movieBackdropImageView.kf.setImage(with: movieViewModel.backdropURL, options: [.transition(.fade(0.2))])
        }
        
        if movieViewModel.hasPosterURL {
            moviePosterImageView.kf.setImage(with: movieViewModel.posterURL, options: [.transition(.fade(0.2))])
        }
        
        movieTitleLabel.text = movieViewModel.title
        movieGenresLabel.text = movieViewModel.genres
        movieReleaseDateLabel.text = movieViewModel.releaseDate
        movieDescriptionLabel.text = movieViewModel.description
    }
}
