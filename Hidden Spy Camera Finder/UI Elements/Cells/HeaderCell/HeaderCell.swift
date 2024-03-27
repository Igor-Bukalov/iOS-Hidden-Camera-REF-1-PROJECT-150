//
//  HeaderCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 15.11.2023.
//

import UIKit
import TinyConstraints

class HeaderCell: UITableViewCell {
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.medium, size: isiPad ? 26 : 16)
        label.textColor = UIColor.customDarkBlue
        label.text = "Test"
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_HSCF()
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews_HSCF() {
        contentView.addSubview(titleLabel)
        titleLabel.topToSuperview()
        titleLabel.leadingToSuperview(offset: isiPad ? 34 : 20)
        titleLabel.trailingToSuperview(offset: isiPad ? -34 : -20)
        titleLabel.bottomToSuperview()
    }
}
