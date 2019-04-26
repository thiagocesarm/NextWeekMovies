//
//  UITableView+Extensions.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 26/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import UIKit

extension UITableView {
    func scrollToTopCell(animated : Bool) {
        let numRows = numberOfRows(inSection: 0)
        if numRows > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
}
