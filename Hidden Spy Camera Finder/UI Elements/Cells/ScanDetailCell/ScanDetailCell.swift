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
        titleTextLabel.font = UIFont.inter(.InterMedium, size: 16)
        [subTitleTextLabel, subTitleValueLabel].forEach { $0.font = UIFont.inter(.InterRegular, size: 12) }
        titleValueButton.titleLabel?.font = UIFont.inter(.InterRegular, size: 14)
        
        [titleTextLabel, subTitleTextLabel, subTitleValueLabel].forEach { $0.textColor = UIColor.blueLabel }
        contentView.backgroundColor = UIColor.cellBackground
        
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.blueLabel.cgColor
        contentView.layer.cornerRadius = 16
        
        selectionStyle = .none
    }
    
    @IBAction func my_actionTapped_rudk_hpsd(_ sender: UIButton) {
        actionTapped?()
    }
}
