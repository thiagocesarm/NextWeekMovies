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

    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var labelsView: UIView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieGenresLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    
    var movieViewModel: MovieViewModel! {
        didSet {
            moviePosterImageView.kf.setImage(with: movieViewModel.posterURL, options: [.transition(.fade(0.5))])
            movieTitleLabel.text = movieViewModel.title
            movieGenresLabel.text = movieViewModel.genres
            movieReleaseDateLabel.text = movieViewModel.releaseDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
