//
//  AntiSpyDetailsCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 14.11.2023.
//

import UIKit
import TinyConstraints

class AntiSpyDetailsCell: UITableViewCell {
    // MARK: - UIProperties
    lazy var imgView = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.inter(.InterMedium, size: 16)
        label.textColor = UIColor.blueLabel
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Test"
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.inter(.InterRegular, size: 14)
        label.textColor = UIColor.blueLabel
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
        imgView.height(40)
        imgView.width(40)
        
        // Horizontal stack
        let headerStackView = UIStackView(arrangedSubviews: [imgView, titleLabel])
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = 10
        
        // Separator
        let separatorView = UIView()
        separatorView.backgroundColor = .hex("294167")
        separatorView.layer.opacity = 0.05
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Vertical stack
        let verticalStackView = UIStackView(arrangedSubviews: [headerStackView, separatorView, subtitleLabel])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 6
        
        contentView.addSubview(verticalStackView)
        
        verticalStackView.topToSuperview(offset: 16)
        verticalStackView.leftToSuperview(offset: 20)
        verticalStackView.rightToSuperview(offset: -20)
        verticalStackView.bottomToSuperview(offset: -16)
    }
}
