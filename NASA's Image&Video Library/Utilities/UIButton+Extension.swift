//
//  UIButton+Extension.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 03/03/2021.
//

import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 0.9
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        self.layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.7
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        self.layer.add(flash, forKey: nil)
    }
}
