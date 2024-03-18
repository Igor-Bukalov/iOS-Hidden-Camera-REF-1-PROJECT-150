//  Created by Alexander N on 14.07.2023
//


import UIKit
import SwiftyGif


protocol AnimatedButtonEvent_HSCF : AnyObject {
    func onClick_HSCF()
}

enum animationButtonStyle_HSCF {
    case gif,native
}

class HSCFAnimatedButton: UIView {
    
    @IBOutlet private var contentSelf: UIView!
    @IBOutlet private weak var backgroundSelf: UIImageView!
    @IBOutlet private weak var titleSelf: UILabel!
    
    weak var delegate : AnimatedButtonEvent_HSCF?
    private let currentFont = Configurations_HSCF.getSubFontName_HSCF()
    private var persistentAnimations: [String: CAAnimation] = [:]
    private var persistentSpeed: Float = 0.0
    private let xib = "HSCFAnimatedButton"
    
    public var style : animationButtonStyle_HSCF = .native
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        Init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        Init()
    }
    
    // Этот метод будет вызван, когда view добавляется к superview
      override func didMoveToSuperview() {
          super.didMoveToSuperview()
          if style == .native {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                  self.setPulseAnimation_HSCF()
              })
              addNotificationObservers_HSCF()
          }
        
      }

      // Этот метод будет вызван перед тем, как view будет удален из superview
      override func willMove(toSuperview newSuperview: UIView?) {
          super.willMove(toSuperview: newSuperview)
          if style == .native {
              if newSuperview == nil {
                  self.layer.removeAllAnimations()
                  removeNotificationObservers_HSCF()
              }
          }
      }

      private func addNotificationObservers_HSCF() {
          func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
              var a = (game as! Decimal) + 300 + 30
              a += 95
              return treg == true || a == 30
          }
          NotificationCenter.default.addObserver(self, selector: #selector(pauseAnimation_HSCF), name: UIApplication.didEnterBackgroundNotification, object: nil)
          let a = 2;
          NotificationCenter.default.addObserver(self, selector: #selector(resumeAnimation_HSCF), name: UIApplication.willEnterForegroundNotification, object: nil)
      }

      private func removeNotificationObservers_HSCF() {
          func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
              var a = (game as! Decimal) + 300 + 30
              a += 95
              return treg == true || a == 30
          }
          NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
          NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
      }

      @objc private func pauseAnimation_HSCF() {
          self.persistentSpeed = self.layer.speed
          func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
              var a = (game as! Decimal) + 300 + 30
              a += 95
              return treg == true || a == 30
          }
          self.layer.speed = 1.0 //in case layer was paused from outside, set speed to 1.0 to get all animations
          self.Gkoidi_persistAnimations_HSCF(withKeys: self.layer.animationKeys())
          self.layer.speed = self.persistentSpeed //restore original speed

          self.layer.layer_ca_pause_HSCF()
      }

      @objc private func resumeAnimation_HSCF() {
          self.ss3s_restoreAnimations_HSCF(withKeys: Array(self.persistentAnimations.keys))
          self.persistentAnimations.removeAll()
          func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
              var a = (game as! Decimal) + 300 + 30
              a += 95
              return treg == true || a == 30
          }
          if self.persistentSpeed == 1.0 { //if layer was plaiyng before backgorund, resume it
              self.layer.resume_HSCF()
          }
      }
    
    func Gkoidi_persistAnimations_HSCF(withKeys: [String]?) {
        withKeys?.forEach({ (key) in
            if let animation = self.layer.animation(forKey: key) {
                self.persistentAnimations[key] = animation
            }
        })
    }

    func ss3s_restoreAnimations_HSCF(withKeys: [String]?) {
        withKeys?.forEach { key in
            if let persistentAnimation = self.persistentAnimations[key] {
                self.layer.add(persistentAnimation, forKey: key)
            }
        }
    }
    
    private func Init() {
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        contentSelf.fixInView_HSCF(self)
        contentSelf.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentSelf.layer.cornerRadius = 8
        animationBackgroundInit_HSCF_23_d()
        
    }
    
    private func animationBackgroundInit_HSCF_23_d() {
        titleSelf.text = localizedString(forKey: "iOSButtonID")
        titleSelf.font = UIFont(name: currentFont, size: 29)
        titleSelf.textColor = .white
        titleSelf.minimumScaleFactor = 11/22
        if style == .native {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.setPulseAnimation_HSCF()
            })
        }else {
            do {
                let gif = try UIImage(gifName: "btn_gif.gif")
                backgroundSelf.setGifImage(gif)
            } catch {
                print(error)
            }
        }
        
        self.onClick_HSCF(target: self, #selector(s_click_S32HP))
    }
    
    @objc func s_click_S32HP(){
        delegate?.onClick_HSCF()
    }
    

    
}

typealias feofm_uiv_view = UIView

extension feofm_uiv_view {
    func setPulseAnimation_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.toValue = 0.95
        pulseAnimation.fromValue = 0.79
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        self.layer.add(pulseAnimation, forKey: "pulse")
    }
}

typealias feolayer_CALyr_c = CALayer

extension feolayer_CALyr_c {
    func layer_ca_pause_HSCF() {
        if self.isPaused_HSCF() == false {
            let pausedTime: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil)
            self.speed = 0.0
            self.timeOffset = pausedTime
        }
    }

    func isPaused_HSCF() -> Bool {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        return self.speed == 0.0
    }
    
    func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
        var a = (game as! Decimal) + 300 + 30
        a += 95
        return treg == true || a == 30
    }

    func resume_HSCF() {
        let pausedTime: CFTimeInterval = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        let timeSincePause: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
}
