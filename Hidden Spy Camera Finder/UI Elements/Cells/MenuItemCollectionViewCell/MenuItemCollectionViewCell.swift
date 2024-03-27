//
//  MenuItemCollectionViewCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 21.03.2024.
//

import UIKit
import TinyConstraints

class MenuItemCollectionViewCell: UICollectionViewCell {
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.width(isiPad ? 67 : 40)
        iv.aspectRatio(1)
        return iv
    }()
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
        
        imageView.centerXToSuperview()
        imageView.topToSuperview(offset: isiPad ? 26 : 16)
        
        label.centerXToSuperview()
        label.bottomToSuperview(offset: isiPad ? -26 : -16)
        
        label.font = UIFont.gilroy(.medium, size: isiPad ? 23 : 14)
        label.textAlignment = .center
    }
    
    func configure(with title: String, image: UIImage?) {
        label.text = title
        imageView.image = image
    }
}
