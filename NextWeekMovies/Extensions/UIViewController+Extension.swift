//
//  UIViewController+Extension.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 25/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
