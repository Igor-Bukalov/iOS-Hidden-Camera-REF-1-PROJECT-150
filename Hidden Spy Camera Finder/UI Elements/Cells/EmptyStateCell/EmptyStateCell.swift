//
//  EmptyStateCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 15.11.2023.
//

import UIKit
import TinyConstraints

class EmptyStateCell: UITableViewCell {
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    // MARK: - UIProperties
    lazy var imgView = UIImageView(image: UIImage.init(named: "empty-state-icon"))
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.medium, size: isiPad ? 26 : 16)
        label.textColor = UIColor.customDarkBlue
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Empty"
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_HSCF()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews_HSCF() {
        contentView.addSubview(imgView)
        imgView.height(isiPad ? 134 : 80)
        imgView.width(isiPad ? 134 : 80)
        imgView.centerXToSuperview()
        imgView.topToSuperview(offset: isiPad ? 180 : 90)
        
        contentView.addSubview(titleLabel)
        titleLabel.topToBottom(of: imgView, offset: isiPad ? 20 : 12)
        titleLabel.leadingToSuperview()
        titleLabel.trailingToSuperview()
        titleLabel.bottomToSuperview()
    }
}
