//
//  AnimationExtension.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 29/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

extension UIView {
    func FadeIn(_ duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }) { _ in
            guard (completion != nil) else {
                return
            }
            completion!()
        }
    }
    
    func FadeOut(_ duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }) { _ in
            guard (completion != nil) else {
                return
            }
            completion!()
        }
    }
}
