//  Created by Alexander N on 14.07.2023
//


import UIKit

class HSCFReusableCell_HSCF: UICollectionViewCell {
    
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stadii_setupCell_HSCF()
    }
    
    func stadii_setupCell_HSCF() {
        cellLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cellLabel.font = UIFont(name: Configurations_HSCF.getSubFontName_HSCF(), size: 10)
        contentContainer.layer.cornerRadius = 8
        titleContainer.layer.cornerRadius = 8
        cellLabel.setShadow_S32HP(with: 0.5)
        cellImage.layer.cornerRadius = 8
//        cellImage.layer.borderColor = UIColor.black.cgColor
//        cellImage.layer.borderWidth = 2
    }
}
