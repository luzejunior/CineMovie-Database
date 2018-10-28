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
            containerView.alpha = 0.0
            containerView.layer.cornerRadius = 30
            containerView.layer.shadowOffset = CGSize(width: 6, height: 5)
            containerView.layer.shadowOpacity = 0.29
            containerView.layer.shadowRadius = 7
        }
    }
    @IBOutlet var transparentView: UIView! {
        didSet {
            transparentView.alpha = 0.0
        }
    }
    
    weak var viewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        openModal()
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
    
    private func openModal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.containerView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.transparentView.alpha = 1.0
            }
        }
    }
    
    // Close modal
    func didTouchModal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.containerView.alpha = 0.0
            self.transparentView.alpha = 0.0
        }) { _ in
            print("completed")
            self.viewController?.dismiss(animated: false, completion: nil)
            self.viewController = nil
            self.dismiss(animated: false, completion: nil)
        }
    }
}
