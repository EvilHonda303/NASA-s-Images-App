//
//  UIColor+Extension.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

extension UIColor {
    static var superViolet: UIColor {
        if let color = UIColor(named: "ultra-violet-pantone") {
            return color
        } else {
            return .purple
        }
    }
    
    static var fruitDove: UIColor {
        if let color = UIColor(named: "fruit-dove") {
            return color
        } else {
            return .red
        }
    }
}
