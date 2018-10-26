//
//  ModalViewController.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController, Storyboarded {
    
    // IBOutlets
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 30
            containerView.layer.shadowOffset = CGSize(width: 6, height: 5)
            containerView.layer.shadowOpacity = 0.29
            containerView.layer.shadowRadius = 7
        }
    }
    
    weak var viewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModal()
    }
    
    // Configure viewController inside containerView
    private func configureModal() {
        guard let viewController = self.viewController else {
            return
        }
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(viewController.view)
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    // Close modal
    func didTouchModal() {
        viewController?.dismiss(animated: false, completion: nil)
        viewController = nil
        self.dismiss(animated: false, completion: nil)
    }
}
