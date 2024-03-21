//
//  ScanDetailCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 09.11.2023.
//

import UIKit

class ScanDetailCell: UITableViewCell {
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var titleValueButton: UIButton!
    
    @IBOutlet weak var subTitleTextLabel: UILabel!
    @IBOutlet weak var subTitleValueLabel: UILabel!
    
    var actionTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        titleTextLabel.font = UIFont.gilroy(.GilroyMedium, size: 16)
        [subTitleTextLabel, subTitleValueLabel].forEach { $0.font = UIFont.gilroy(.GilroySemibold, size: 12) }
        titleValueButton.titleLabel?.font = UIFont.gilroy(.GilroySemibold, size: 14)
        
        [titleTextLabel, subTitleTextLabel, subTitleValueLabel].forEach { $0.textColor = UIColor.blueLabel }
        contentView.backgroundColor = UIColor.cellBackground
        selectionStyle = .none
    }
    
    @IBAction func my_actionTapped_rudk_hpsd(_ sender: UIButton) {
        actionTapped?()
    }
}

class ScanDetailCell1: UITableViewCell {
    // MARK: - UIProperties
    lazy var titleTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.GilroyMedium, size: 16)
        lbl.textColor = UIColor.blueLabel
        lbl.numberOfLines = 1
        lbl.text = "Test"
        return lbl
    }()
    
    lazy var titleValueButton: UIButton = {
        let b = UIButton(type: .system)
        b.titleLabel?.font = UIFont.gilroy(.GilroyMedium, size: 14)
        b.setTitle("Copy MAC", for: .normal)
        b.setTitleColor(UIColor.hex("4680E4"), for: .normal)
        b.addTarget(self, action: #selector(copyMAC), for: .touchUpInside)
        return b
    }()
    
    lazy var subtitleTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.GilroyMedium, size: 12)
        lbl.textColor = UIColor.blueLabel
        lbl.numberOfLines = 1
        lbl.text = "Test"
        return lbl
    }()
    
    lazy var subtitleValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.GilroyMedium, size: 12)
        lbl.textColor = UIColor.blueLabel
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
        backgroundColor = .cellBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        let leftVerticalStack = UIStackView(arrangedSubviews: [titleTextLabel, subtitleTextLabel])
        leftVerticalStack.axis = .vertical
        leftVerticalStack.alignment = .leading
        leftVerticalStack.spacing = 4
        
        let rightVerticalStack = UIStackView(arrangedSubviews: [titleValueButton, subtitleValueLabel])
        rightVerticalStack.axis = .vertical
        rightVerticalStack.alignment = .trailing
        rightVerticalStack.spacing = 4
        
        contentView.addSubview(leftVerticalStack)
        
        leftVerticalStack.topToSuperview(offset: 10)
        leftVerticalStack.leftToSuperview(offset: 12)
        leftVerticalStack.bottomToSuperview(offset: -10)
        
        contentView.addSubview(rightVerticalStack)
        
        rightVerticalStack.topToSuperview(offset: 10)
        rightVerticalStack.rightToSuperview(offset: -12)
        rightVerticalStack.bottomToSuperview(offset: -10)
    }
}
