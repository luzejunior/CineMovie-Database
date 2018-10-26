//
//  BaseViewController.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

// Abstract base view controller class to include activity indicator inside view controllers
class BaseViewController: UIViewController {

    // Activity indicator instantiation
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
    }
    
    // Activity indicator configuration, centering it at middle of screen.
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
