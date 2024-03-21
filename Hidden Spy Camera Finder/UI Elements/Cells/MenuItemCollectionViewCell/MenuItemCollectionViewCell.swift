//
//  MenuItemCollectionViewCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 21.03.2024.
//

import UIKit
import TinyConstraints

class MenuItemCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.height(40)
        imageView.centerXToSuperview()
        imageView.topToSuperview(offset: 16)
        
        label.centerXToSuperview()
        label.bottomToSuperview(offset: -16)
        
        label.font = UIFont.gilroy(.GilroyMedium, size: 14)
        label.textAlignment = .center
    }
    
    func configure(with title: String, image: UIImage?) {
        label.text = title
        imageView.image = image
    }
}
