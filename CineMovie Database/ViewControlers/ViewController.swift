//
//  ViewController.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    var presenter = ViewControllerPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
    }
    
    func viewDidFinishedLoading() {
        activityIndicator.stopAnimating()
    }
}

