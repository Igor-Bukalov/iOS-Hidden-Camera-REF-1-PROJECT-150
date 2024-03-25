//
//  TutorialCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 21.03.2024.
//

import UIKit
import TinyConstraints

class TutorialCell: UITableViewCell {
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    // MARK: - UIProperties
    lazy var imgView = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 26 : 16)
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
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .cellBackground
        v.layer.cornerRadius = isiPad ? 40 : 24
        v.layer.borderWidth = isiPad ? 1.0 : 0.6
        v.layer.borderColor = UIColor.blueLabel.cgColor
        return v
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews_HSCF() {
        imgView.height(isiPad ? 67 : 40)
        imgView.width(isiPad ? 67 : 40)
        
        let headerStackView = UIStackView(arrangedSubviews: [imgView, titleLabel])
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = isiPad ? 16 : 10
        
        let separatorView = UIView()
        separatorView.backgroundColor = .hex("294167")
        separatorView.layer.opacity = 0.05
        separatorView.height(1)
        
        let verticalStackView = UIStackView(arrangedSubviews: [headerStackView, separatorView, subtitleLabel])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = isiPad ? 11 : 6
        
        containerView.addSubview(verticalStackView)
        verticalStackView.topToSuperview(offset: isiPad ? 26 : 16)
        verticalStackView.leftToSuperview(offset: isiPad ? 33 : 20)
        verticalStackView.rightToSuperview(offset: isiPad ? -33 : -20)
        verticalStackView.bottomToSuperview(offset: isiPad ? -26 : -16)
        
        contentView.addSubview(containerView)
        if isiPad {
            containerView.topToSuperview()
            containerView.bottomToSuperview()
            containerView.centerXToSuperview()
            containerView.width(560)
        } else {
            containerView.edgesToSuperview()
        }
    }
}
