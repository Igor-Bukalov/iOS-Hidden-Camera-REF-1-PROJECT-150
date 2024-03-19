//
//  TutorialViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 13.11.2023.
//

import UIKit
import TinyConstraints
import SwiftUI

class HSCFTutorialViewController: HSCFBaseViewController {
    // MARK: - UIProperties
    private lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.cellBackground
        v.layer.cornerRadius = 24
        v.layer.borderWidth = 0.6
        v.layer.borderColor = UIColor.blueLabel.cgColor
        return v
    }()
    
    private lazy var scrollView = UIScrollView()
    private lazy var bookImageView = UIImageView(image: UIImage(named: "book"))
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.inter(.InterMedium, size: 16)
        lbl.numberOfLines = 0
        lbl.textColor = .blueLabel
        lbl.text = "Tactics for Shooting Against an Ambush"
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var textLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 0 // No indent for the first line
        paragraphStyle.headIndent = 16 // The indent for the remaining lines
        paragraphStyle.lineSpacing = 3
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.inter(.InterRegular, size: 14),
            .foregroundColor: UIColor.hex("8C939F")
        ]
        
        let attributedString = NSAttributedString(
            string: "1. Check whether covert cameras are installed in televisions, light fixtures, wall gaps, fire alarms, sockets, etc., as well as whether the bathroom glass is transparent.\n2. Dim the lighting in the room or turn off the power when the card is removed. Capturing a clear photo of the camera lens under normal room brightness is challenging; a power outage serves as a better safeguard. The camera's energy consumption is relatively high. Typically, the power source in a hotel room is connected to the network. The camera will naturally cease functioning when the entire room's power is switched off. Some hidden cameras may emit a small, predominantly red, bright light during operation. After turning off the entire room's power, neglected flashlights are easier to locate in the darkness.\n3. Close doors and windows and draw the curtains. The initial steps are aimed at preventing monitoring within the room; however, external factors cannot be ignored.\n4. Be vigilant to ensure you're not being followed by others. Do not open the door to strangers willingly (refrain from sales, door-to-door services at unknown times, etc.), and lock the internal door when you're sleeping.\n5. Choose a hotel with a good reputation. The likelihood of being monitored in a small, obscure hotel is significantly higher than in a regular hotel, as regular hotels undergo more stringent checks.",
            attributes: attributes
        )
        lbl.attributedText = attributedString
        
        return lbl
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews_HSCF()
    }
    
    private func setupSubviews_HSCF() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        scrollView.edgesToSuperview()
        
        containerView.topToSuperview(offset: 16, usingSafeArea: true)
        containerView.leadingToSuperview(offset: 20)
        containerView.trailingToSuperview(offset: 20)
        containerView.bottomToSuperview(offset: -16)
        
        // Horizontal stack
        let headerStackView = UIStackView(arrangedSubviews: [bookImageView, titleLabel])
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = 10
        
        // Separator
        let separatorView = UIView()
        separatorView.backgroundColor = .hex("294167")
        separatorView.layer.opacity = 0.05
        separatorView.height(1)
        
        // Vertical stack
        let verticalStackView = UIStackView(arrangedSubviews: [headerStackView, separatorView, textLabel])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 6
        
        containerView.addSubview(verticalStackView)
        
        verticalStackView.topToSuperview(offset: 16)
        verticalStackView.leftToSuperview(offset: 20)
        verticalStackView.rightToSuperview(offset: -20)
        verticalStackView.bottomToSuperview(offset: -16)
        
        bookImageView.height(40)
        bookImageView.width(40)
    }
}

struct HSCFTutorialViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            HSCFTutorialViewController()
        }
    }
}
