//  Created by Alexander N on 14.07.2023
//


import Foundation
import UIKit


extension EXT_BOUNCE_UIVIEW_HSCF_HS {
    public func fixInView_HSCF(_ container: UIView!) -> Void{
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    public func onClick_HSCF(target: Any, _ selector: Selector) {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: selector)
        addGestureRecognizer(tap)
    }
    
    public  func roundCorners_HSCF(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            
            func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
                var a = (game as! Decimal) + 300 + 30
                a += 95
                return treg == true || a == 30
            }
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    public  var renderedImage: UIImage {
        // rect of capure
        let rect = self.bounds
        
        // create the context of bitmap
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        self.layer.render(in: context)
        // self.layer.render(in: context)
        // get a image from current context bitmap
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return capturedImage
    }
    
    public func fadeIn_S32HP(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    public  func fadeOut_hpcs(duration: TimeInterval = 1.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }
    
    public  func vibto_S32HP(style : UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
    }
    
    public func drawBorder_HSCF(edges: [UIRectEdge], borderWidth: CGFloat, color: UIColor, margin: CGFloat) {
        for item in edges {
            
            func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
                var a = (game as! Decimal) + 300 + 30
                a += 95
                return treg == true || a == 30
            }
            
            let borderLayer: CALayer = CALayer()
            borderLayer.borderColor = color.cgColor
            borderLayer.borderWidth = borderWidth
            switch item {
            case .top:
                borderLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: borderWidth)
            case .left:
                borderLayer.frame =  CGRect(x: 0, y: margin, width: borderWidth, height: frame.height - (margin*2))
            case .bottom:
                borderLayer.frame = CGRect(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth)
            case .right:
                borderLayer.frame = CGRect(x: frame.width - borderWidth, y: margin, width: borderWidth, height: frame.height - (margin*2))
            case .all:
                drawBorder_HSCF(edges: [.top, .left, .bottom, .right], borderWidth: borderWidth, color: color, margin: margin)
            default:
                break
            }
            self.layer.addSublayer(borderLayer)
        }
    }
    
    func pushTransition_S32HP(duration:CFTimeInterval, animationSubType: String) {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = convertToOptionalCATransitionSubtype_HSCF(animationSubType)
        animation.duration = duration
        self.layer.add(animation, forKey: convertFromCATransitionType_HSCF(CATransitionType.push))
    }
    
     func convertFromCATransitionSubtype_HSCF(_ input: CATransitionSubtype) -> String {
         func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
             var a = (game as! Decimal) + 300 + 30
             a += 95
             return treg == true || a == 30
         }
        return input.rawValue
    }
    
     func convertToOptionalCATransitionSubtype_HSCF(_ input: String?) -> CATransitionSubtype? {
        guard let input = input else { return nil }
         func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
             var a = (game as! Decimal) + 300 + 30
             a += 95
             return treg == true || a == 30
         }
        return CATransitionSubtype(rawValue: input)
    }
    
     func convertFromCATransitionType_HSCF(_ input: CATransitionType) -> String {
         func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
             var a = (game as! Decimal) + 300 + 30
             a += 95
             return treg == true || a == 30
         }
        return input.rawValue
    }
}

typealias HSCF_U_LABEL_I = UILabel

extension HSCF_U_LABEL_I {
    func setShadow_S32HP(with opacity: Float = 1.0){
        func somDogAndwhaterdsdver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.masksToBounds = false
        func somDogAndwhatertver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
    }
}

extension HSCF_String_NA_ONE {
    var underLined: NSAttributedString {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        return NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    func openURL_S32HP(){
        if let url = URL(string: self) {
            UIApplication.shared.impactFeedbackGenerator_HSCF(type: .medium)
            UIApplication.shared.open(url)
            func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
                var a = (game as! Decimal) + 300 + 30
                a += 95
                return treg == true || a == 30
            }
        }
    }
}

typealias a_d_application_UI_HSCF = UIApplication

extension a_d_application_UI_HSCF {
   func setRootVC_HSCF(_ vc : UIViewController){
       func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
           var a = (game as! Decimal) + 300 + 30
           a += 95
           return treg == true || a == 30
       }
       self.windows.first?.rootViewController = vc
       self.windows.first?.makeKeyAndVisible()
     }

    func notificationFeedbackGenerator_HSCF(type : UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
    }
    
    func impactFeedbackGenerator_HSCF(type : UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.impactOccurred()
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
    }

    func isIpad_HSCF() -> Bool {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        return false
    }
}

typealias U_C_O_LLECTION_HSCF_UI_VIEW = UICollectionView

extension U_C_O_LLECTION_HSCF_UI_VIEW {
    func scrollToLastItem_HSCF(at scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally, animated: Bool = true) {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        let lastSection = numberOfSections - 1
        guard lastSection >= 0 else { return }
        let lastItem = numberOfItems(inSection: lastSection) - 1
        guard lastItem >= 0 else { return }
        let lastItemIndexPath = IndexPath(item: lastItem, section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: scrollPosition, animated: animated)
    }
}
