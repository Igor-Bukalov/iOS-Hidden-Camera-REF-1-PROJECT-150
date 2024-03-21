//
//  TutorialModel.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 21.03.2024.
//

import UIKit

struct TutorialModel: Hashable {
    let image: UIImage?
    let title: String
    let attributedSubtitle: NSAttributedString
    
    static let item: [TutorialModel] = [TutorialModel(
        image: UIImage(named: "book"),
        title: "Tactics for Shooting Against an Ambush",
        attributedSubtitle: TutorialModel.createAttributedSubtitle()
    )]
    
    static func createAttributedSubtitle() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 16
        paragraphStyle.lineSpacing = 6
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.gilroy(.GilroyMedium, size: 14),
            .foregroundColor: UIColor.hex("8C939F")
        ]
        
        let attributedString = NSAttributedString(
            string: "1. Check whether covert cameras are installed in televisions, light fixtures, wall gaps, fire alarms, sockets, etc., as well as whether the bathroom glass is transparent.\n2. Dim the lighting in the room or turn off the power when the card is removed. Capturing a clear photo of the camera lens under normal room brightness is challenging; a power outage serves as a better safeguard. The camera's energy consumption is relatively high. Typically, the power source in a hotel room is connected to the network. The camera will naturally cease functioning when the entire room's power is switched off. Some hidden cameras may emit a small, predominantly red, bright light during operation. After turning off the entire room's power, neglected flashlights are easier to locate in the darkness.\n3. Close doors and windows and draw the curtains. The initial steps are aimed at preventing monitoring within the room; however, external factors cannot be ignored.\n4. Be vigilant to ensure you're not being followed by others. Do not open the door to strangers willingly (refrain from sales, door-to-door services at unknown times, etc.), and lock the internal door when you're sleeping.\n5. Choose a hotel with a good reputation. The likelihood of being monitored in a small, obscure hotel is significantly higher than in a regular hotel, as regular hotels undergo more stringent checks.",
            attributes: attributes
        )
        
        return attributedString
    }
}
