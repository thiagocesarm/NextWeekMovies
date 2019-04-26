//
//  LoadingSpinnerViewController.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 25/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import UIKit

class LoadingSpinnerViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var spinner = UIActivityIndicatorView(style: .whiteLarge)
    private var spinnerIsOn = false
    
    // MARK: - Public properties
    
    var isSpinnig: Bool {
        return spinnerIsOn
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Public methods
    
    func startSpinner(onViewController presentingViewController: UIViewController) {
            presentingViewController.addChild(self)
            self.view.frame = presentingViewController.view.frame
            presentingViewController.view.addSubview(self.view)
            self.didMove(toParent: presentingViewController)
            spinnerIsOn = true
    }
    
    func stopSpinner() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        spinnerIsOn = false
    }

}
