//
//  ScanDetailLanDeviceCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 15.11.2023.
//

import UIKit
import TinyConstraints

class ScanDetailLanDeviceCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroyMedium, size: 16)
        label.textColor = UIColor.blueLabel
        label.text = "Test"
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroyMedium, size: 12)
        label.textColor = UIColor.blueLabel
        label.text = "Test"
        return label
    }()
    
    lazy var leftImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "exclamation-mark"))
        return img
    }()
    
    lazy var deleteButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "trash-can"), for: .normal)
        b.addTarget(self, action: #selector(copyMAC), for: .touchUpInside)
        return b
    }()
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .cellBackground
        v.layer.cornerRadius = 20
        v.layer.borderWidth = 0.6
        v.layer.borderColor = UIColor.blueLabel.cgColor
        return v
    }()
    
    var actionTapped: (() -> Void)?
    
    @objc func copyMAC() {
        actionTapped?()
    }
    
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
        contentView.addSubview(containerView)
        containerView.topToSuperview(offset: 6)
        containerView.leadingToSuperview(offset: 20)
        containerView.trailingToSuperview(offset: 20)
        containerView.bottomToSuperview(offset: -6)
        
        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        verticalStack.axis = .vertical
        verticalStack.alignment = .fill
        verticalStack.spacing = 4
        
        let horizontalStack = UIStackView(arrangedSubviews: [leftImageView, verticalStack])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        verticalStack.alignment = .leading
        horizontalStack.spacing = 0
        containerView.addSubview(horizontalStack)
        
        horizontalStack.leadingToSuperview(offset: 12)
        horizontalStack.topToSuperview(offset: 17)
        horizontalStack.bottomToSuperview(offset: -17)
        
        containerView.addSubview(deleteButton)
        
        leftImageView.centerYToSuperview()
        
        deleteButton.rightToSuperview(offset: -12)
        deleteButton.centerYToSuperview()
    }
}
