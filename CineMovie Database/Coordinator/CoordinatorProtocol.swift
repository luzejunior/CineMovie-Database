//
//  CoordinatorProtocol.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

protocol Coordinatable {
    var navigationController: UINavigationController? { get set }
    var window: UIWindow? { get set }
    func startCoordinator()
}

extension Coordinatable {
    func pushViewController(_ view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}

protocol Storyboarded {
    static func Instantiate() -> Self
}

// Method to instantiate UIVIewControllers
extension Storyboarded where Self: UIViewController {
    static func Instantiate() -> Self {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}
