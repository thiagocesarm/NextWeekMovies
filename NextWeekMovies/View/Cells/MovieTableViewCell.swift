//
//  MovieTableViewCell.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 23/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var labelsView: UIView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieGenresLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    
    // MARK: - Public properties
    
    var movieViewModel: MovieViewModel! {
        didSet {
            if movieViewModel.hasPosterURL {
                moviePosterImageView.kf.indicatorType = .activity
                moviePosterImageView.kf.setImage(with: movieViewModel.posterURL)
            } else {
                moviePosterImageView.image = UIImage(named: "noImageAvailable")
            }
            movieTitleLabel.text = movieViewModel.title
            movieGenresLabel.text = movieViewModel.genres
            movieReleaseDateLabel.text = movieViewModel.releaseDate
        }
    }
}
