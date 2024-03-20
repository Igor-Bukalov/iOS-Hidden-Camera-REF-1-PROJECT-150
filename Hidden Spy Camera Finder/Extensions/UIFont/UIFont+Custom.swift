//
//  UIFont+Custom.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit

enum GilroyFont: String {
    case GilroyMedium = "Gilroy-Medium"
    case GilroySemibold = "Gilroy-Semibold"
}

typealias HSCF_UIFONT_HS_OE = UIFont

extension HSCF_UIFONT_HS_OE {
    convenience init?(name: GilroyFont, size: CGFloat) {
        self.init(name: name.rawValue, size: size)
    }
}

extension HSCF_UIFONT_HS_OE {
    static let defaultFont = UIFont().withSize(16)
    
    static func gilroy(_ gilroy: GilroyFont, size: CGFloat) -> UIFont {
        return UIFont(name: gilroy, size: size) ?? defaultFont
    }
}
