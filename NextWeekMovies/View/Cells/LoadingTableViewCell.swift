//
//  LoadingTableViewCell.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 24/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}
