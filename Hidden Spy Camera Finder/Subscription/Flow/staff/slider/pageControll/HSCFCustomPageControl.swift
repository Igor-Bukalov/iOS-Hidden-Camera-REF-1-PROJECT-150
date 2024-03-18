//  Created by Alexander N on 14.07.2023
//

import Foundation
import UIKit

class HSCFCustomPageControl: UIPageControl {

    @IBInspectable var currentPageImage: UIImage? = UIImage(named: "page_1")
    
    @IBInspectable var otherPagesImage: UIImage? = UIImage(named: "page_0")
    
    override var numberOfPages: Int {
        didSet {
            updateDots_HSCF()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateDots_HSCF()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove_HSCF()
        } else {
            pageIndicatorTintColor = .clear
            currentPageIndicatorTintColor = .clear
            clipsToBounds = false
        }
    }
    
    private func defaultConfigurationForiOS14AndAbove_HSCF() {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        if #available(iOS 14.0, *) {
            for index in 0..<numberOfPages {
                let image = index == currentPage ? currentPageImage : otherPagesImage
                setIndicatorImage(image, forPage: index)
            }

            // give the same color as "otherPagesImage" color.
            pageIndicatorTintColor =  .lightGray
            //
            //  rgba(209, 209, 214, 1)
            // give the same color as "currentPageImage" color.
            //
            
            currentPageIndicatorTintColor = .black
            /*
             Note: If Tint color set to default, Indicator image is not showing. So, give the same tint color based on your Custome Image.
             */
        }
    }
    
    private func updateDots_HSCF() {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove_HSCF()
        } else {
            for (index, subview) in subviews.enumerated() {
                let imageView: UIImageView
                if let existingImageview = getImageView_HSCF(forSubview: subview) {
                    imageView = existingImageview
                } else {
                    imageView = UIImageView(image: otherPagesImage)
                    
                    imageView.center = subview.center
                    subview.addSubview(imageView)
                    subview.clipsToBounds = false
                }
                imageView.image = currentPage == index ? currentPageImage : otherPagesImage
            }
        }
    }
    
    private func getImageView_HSCF(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            
            func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
                var a = (game as! Decimal) + 300 + 30
                a += 95
                return treg == true || a == 30
            }
            
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
            } as? UIImageView
            
            return view
        }
    }
}
