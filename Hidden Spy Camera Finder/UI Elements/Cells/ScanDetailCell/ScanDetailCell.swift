//
//  ScanDetailCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 09.11.2023.
//

import UIKit

class ScanDetailCell: UITableViewCell {
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    // MARK: - UIProperties
    lazy var titleTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.medium, size: isiPad ? 26 : 16)
        lbl.textColor = UIColor.customDarkBlue
        lbl.numberOfLines = 1
        lbl.text = "Test"
        return lbl
    }()
    
    lazy var titleValueButton: UIButton = {
        let b = UIButton(type: .system)
        b.titleLabel?.font = UIFont.gilroy(.medium, size: isiPad ? 23 : 14)
        b.setTitle("Copy MAC", for: .normal)
        b.setTitleColor(UIColor.customLightBlue, for: .normal)
        b.addTarget(self, action: #selector(copyMAC), for: .touchUpInside)
        return b
    }()
    
    lazy var subtitleTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.medium, size: isiPad ? 20 : 12)
        lbl.textColor = UIColor.customDarkBlue
        lbl.numberOfLines = 1
        lbl.text = "Test"
        return lbl
    }()
    
    lazy var subtitleValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.medium, size: isiPad ? 20 : 12)
        lbl.textColor = UIColor.customDarkBlue
        lbl.numberOfLines = 1
        lbl.text = "Test"
        return lbl
    }()
    
    var actionTapped: (() -> Void)?
    
    @objc func copyMAC() {
        actionTapped?()
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        selectionStyle = .none
        backgroundColor = UIColor.customCellBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        let leftVerticalStack = UIStackView(arrangedSubviews: [titleTextLabel, subtitleTextLabel])
        leftVerticalStack.axis = .vertical
        leftVerticalStack.alignment = .leading
        leftVerticalStack.spacing = isiPad ? 6 : 4
        
        let rightVerticalStack = UIStackView(arrangedSubviews: [titleValueButton, subtitleValueLabel])
        rightVerticalStack.axis = .vertical
        rightVerticalStack.alignment = .trailing
        rightVerticalStack.spacing = isiPad ? 6 : 4
        
        contentView.addSubview(leftVerticalStack)
        
        leftVerticalStack.topToSuperview(offset: isiPad ? 26 : 10)
        leftVerticalStack.leftToSuperview(offset: isiPad ? 20 : 12)
        leftVerticalStack.bottomToSuperview(offset: isiPad ? -26 : -10)
        
        contentView.addSubview(rightVerticalStack)
        
        rightVerticalStack.topToSuperview(offset: isiPad ? 26 : 10)
        rightVerticalStack.rightToSuperview(offset: isiPad ? -20 : -12)
        rightVerticalStack.bottomToSuperview(offset: isiPad ? -26 : -10)
    }
}
