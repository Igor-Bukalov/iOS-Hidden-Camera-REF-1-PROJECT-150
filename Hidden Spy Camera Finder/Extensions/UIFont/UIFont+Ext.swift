//
//  UIFont+Ext.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 26.03.2024.
//

import UIKit

enum GilroyFont: String {
    case medium = "Gilroy-Medium"
    case semibold = "Gilroy-Semibold"
}

extension UIFont {
    static func gilroy(_ style: GilroyFont, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
