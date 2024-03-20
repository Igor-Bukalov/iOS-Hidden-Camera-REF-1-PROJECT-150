//
//  TutorialCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 21.03.2024.
//

import UIKit
import TinyConstraints

class TutorialCell: UITableViewCell {
    // MARK: - UIProperties
    lazy var imgView = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.GilroyMedium, size: 16)
        lbl.textColor = UIColor.blueLabel
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.text = "Test"
        return lbl
    }()
    
    lazy var subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.attributedText = NSAttributedString()
        return lbl
    }()
    
    func configure(with model: TutorialModel) {
        imgView.image = model.image
        titleLabel.text = model.title
        subtitleLabel.attributedText = model.attributedSubtitle
    }
    
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
        
        let headerStackView = UIStackView(arrangedSubviews: [imgView, titleLabel])
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = 10
        
        let separatorView = UIView()
        separatorView.backgroundColor = .hex("294167")
        separatorView.layer.opacity = 0.05
        separatorView.height(1)
        
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
