//
//  ScanDetailTextCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 09.11.2023.
//

import UIKit
import TinyConstraints

class ScanDetailTextCell: UITableViewCell {
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.medium, size: isiPad ? 23 : 14)
        label.textColor = UIColor.customDarkBlue
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Copy the MAC address as you can\nget detailed information about the device"
        return label
    }()
    
    private lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.layer.borderWidth = isiPad ? 1.5 : 1
        v.layer.borderColor = UIColor.customDarkBlue.cgColor
        v.layer.cornerRadius = isiPad ? 33 : 20
        return v
    }()
    
    private func setupSubviews_HSCF() {
        contentView.addSubview(containerView)
        if isiPad {
            containerView.edgesToSuperview()
            
            containerView.addSubview(label)
            label.topToSuperview(offset: 16)
            label.centerXToSuperview()
            label.bottomToSuperview(offset: -16)
        } else {
            containerView.edgesToSuperview()
            
            containerView.addSubview(label)
            label.topToSuperview(offset: 14)
            label.centerXToSuperview()
            label.bottomToSuperview(offset: -14)
        }
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

