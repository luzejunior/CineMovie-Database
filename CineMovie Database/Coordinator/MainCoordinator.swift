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
    
    // View controllers handled by this coordinator
    var mainViewController: ViewController?
    weak var defaultModal: ModalViewController?
    weak var movieModal: MovieModal?
    
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
    
    // Instantiate movie overview view
    func didTouchTableViewRow(movie: MovieData) {
        movieModal = MovieModal.Instantiate()
        movieModal?.coordinator = self
        let movieModalPresenter = MovieModalPresenter(movie: movie)
        movieModal?.presenter = movieModalPresenter
        presentModal(movieModal)
    }
    
    // On touch close button inside modal
    func didTouchCloseModal() {
        defaultModal?.didTouchModal()
    }
    
    // Present modal view
    private func presentModal(_ viewController: UIViewController?, animated: Bool = false) {
        guard let viewController = viewController else {
            return
        }
        defaultModal = ModalViewController.Instantiate()
        defaultModal?.modalPresentationStyle = .overCurrentContext
        defaultModal?.viewController = viewController
        self.navigationController!.present(defaultModal!, animated: animated, completion: nil)
    }
}
