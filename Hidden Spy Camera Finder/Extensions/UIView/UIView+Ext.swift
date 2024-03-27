//
//  UIView+Ext.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 26.03.2024.
//

import UIKit

enum AnimationIntensity {
    case gentle, moderate, intense
}

extension UIView {
    func applyBounce(intensity: AnimationIntensity, repeatAnimation: Bool = false, completion: ((Bool) -> ())? = nil) {
        let scale: CGFloat
        switch intensity {
        case .gentle: scale = 0.96
        case .moderate: scale = 0.9
        case .intense: scale = 0.6
        }
        
        transform = CGAffineTransform(scaleX: scale, y: scale)
        let options: UIView.AnimationOptions = repeatAnimation ? [.curveEaseInOut, .autoreverse, .repeat] : .allowAnimatedContent
        let damping = repeatAnimation ? 5.5 : 0.2
        let velocity = repeatAnimation ? 5.0 : 3.0
        let duration = repeatAnimation ? 0.5 : 0.3
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: { self.transform = .identity }, completion: completion)
    }
}
