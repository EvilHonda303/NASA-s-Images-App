//
//  UIView+Extension.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 04/03/2021.
//

import UIKit

extension UIView {
    func dropShadow() {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 5
    }
}
