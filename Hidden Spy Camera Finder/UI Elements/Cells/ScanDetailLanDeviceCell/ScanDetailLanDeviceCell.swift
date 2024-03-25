//
//  ScanDetailLanDeviceCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 15.11.2023.
//

import UIKit
import TinyConstraints

class ScanDetailLanDeviceCell: UITableViewCell {
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 26 : 16)
        label.textColor = UIColor.blueLabel
        label.text = "Test"
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 20 : 12)
        label.textColor = UIColor.blueLabel
        label.text = "Test"
        return label
    }()
    
    lazy var leftImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "exclamation-mark"))
        img.width(isiPad ? 53 : 32)
        img.aspectRatio(1)
        return img
    }()
    
    lazy var deleteButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "trash-can"), for: .normal)
        b.imageView?.width(isiPad ? 53 : 32)
        b.imageView?.aspectRatio(1)
        b.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        return b
    }()
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .cellBackground
        v.layer.cornerRadius = isiPad ? 33 : 20
        v.layer.borderWidth = isiPad ? 1.0 : 0.6
        v.layer.borderColor = UIColor.blueLabel.cgColor
        return v
    }()
    
    var actionTapped: (() -> Void)?
    
    @objc func deleteItem() {
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
        if isiPad {
            containerView.topToSuperview(offset: 20)
            containerView.centerXToSuperview()
            containerView.bottomToSuperview()
            containerView.width(560)
            containerView.height(120)
        } else {
            containerView.topToSuperview(offset: 12)
            containerView.leadingToSuperview(offset: 20)
            containerView.trailingToSuperview(offset: 20)
            containerView.bottomToSuperview()
            containerView.height(72)
        }
        
        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        verticalStack.axis = .vertical
        verticalStack.alignment = .fill
        verticalStack.spacing = isiPad ? 6 : 4
        
        let horizontalStack = UIStackView(arrangedSubviews: [leftImageView, verticalStack])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        verticalStack.alignment = .leading
        horizontalStack.spacing = 0
        
        containerView.addSubview(horizontalStack)
        horizontalStack.leftToSuperview(offset: isiPad ? 20 : 12)
        horizontalStack.centerYToSuperview()
        
        containerView.addSubview(deleteButton)
        deleteButton.rightToSuperview(offset: isiPad ? -20 : -12)
        deleteButton.centerYToSuperview()
    }
}
