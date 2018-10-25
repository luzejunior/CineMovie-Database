//
//  MainCoordinator.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinatable {
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    // Coordinator's view controllers
    var mainViewController: ViewController?
    
    // Init coordinator
    init(_ navigationController: UINavigationController, _ window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    // Start first coordinator view controller
    func startCoordinator() {
        mainViewController = ViewController.Instantiate()
        mainViewController?.coordinator = self
        self.pushViewController(mainViewController!)
    }
}
