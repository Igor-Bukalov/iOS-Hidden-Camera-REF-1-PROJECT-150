//
//  AntiSpyDetailsCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 14.11.2023.
//

import UIKit
import TinyConstraints

class AntiSpyDetailsCell: UITableViewCell {
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    // MARK: - UIProperties
    lazy var imgView = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 26 : 16)
        label.textColor = UIColor.blueLabel
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Test"
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 23 : 14)
        label.textColor = UIColor.hex("8C939F")
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Test"
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_HSCF()
        selectionStyle = .none
        
        backgroundColor = .cellBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews_HSCF() {
        imgView.height(isiPad ? 67 : 40)
        imgView.width(isiPad ? 67 : 40)
        
        // Horizontal stack
        let headerStackView = UIStackView(arrangedSubviews: [imgView, titleLabel])
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = isiPad ? 16 : 10
        
        // Separator
        let separatorView = UIView()
        separatorView.backgroundColor = .hex("294167")
        separatorView.layer.opacity = 0.05
        separatorView.height(1)
        
        // Vertical stack
        let verticalStackView = UIStackView(arrangedSubviews: [headerStackView, separatorView, subtitleLabel])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = isiPad ? 10 : 6
        
        contentView.addSubview(verticalStackView)
        
        verticalStackView.topToSuperview(offset: isiPad ? 26 : 16)
        verticalStackView.leftToSuperview(offset: isiPad ? 33 : 20)
        verticalStackView.rightToSuperview(offset: isiPad ? -33 : -20)
        verticalStackView.bottomToSuperview(offset: isiPad ? -26 : -16)
    }
}
