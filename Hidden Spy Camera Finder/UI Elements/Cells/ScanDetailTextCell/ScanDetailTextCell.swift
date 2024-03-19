//
//  ScanDetailTextCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 09.11.2023.
//

import UIKit
import TinyConstraints

class ScanDetailTextCell: UITableViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.inter(.InterRegular, size: 14)
        label.textColor = UIColor.blueLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Copy the MAC address as you can get detailed information about the device"
        return label
    }()
    
    private lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.blueLabel.cgColor
        v.layer.cornerRadius = 20
        return v
    }()
    
    private func setupSubviews_HSCF() {
        contentView.addSubview(containerView)
        containerView.edgesToSuperview()
        containerView.addSubview(label)
        label.topToSuperview(offset: 10)
        label.leftToSuperview(offset: 11)
        label.rightToSuperview(offset: -11)
        label.bottomToSuperview(offset: -10)
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_HSCF()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

