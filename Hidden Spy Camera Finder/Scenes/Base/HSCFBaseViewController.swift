//
//  BaseViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import SwiftUI

class HSCFBaseViewController: UIViewController {
    private var alert: UIAlertController?
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customBackground
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-button")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu-button")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(menuButtonPressed))
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(internerConntectionHandle), name: .connectivityStatus, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc func menuButtonPressed() {
        menuView.isHidden = false
        menuView.transform = CGAffineTransform(translationX: 0, y: -menuView.frame.height)
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.9,
            options: [.curveEaseInOut],
            animations: {
                menuView.transform = .identity
            }, completion: nil
        )
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func internerConntectionHandle() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if HSCFNetworkMonitor.shared.isConnected {
                if let alert {
                    alert.dismiss(animated: true)
                    self.alert = nil
                }
            } else {
                if alert == nil {
                    self.alert = UIAlertController(title: "No Internet Connection", message: nil, preferredStyle: .alert)
                    self.present(self.alert!, animated: true)
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

private func swizzle(
    targetClass: AnyClass,
    originalSelector: Selector,
    swizzledSelector: Selector
) {
    let originalMethod = class_getInstanceMethod(targetClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(targetClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

extension UIViewController {
    static let classInit: Void = {
        let originalSelector = #selector(viewWillAppear(_:))
        let swizzledSelector = #selector(swizzledViewWillAppear(_:))
        swizzle(
            targetClass: UIViewController.self,
            originalSelector: originalSelector,
            swizzledSelector: swizzledSelector
        )
    }()
    
    /// Hides the iOS 14 navigation menu (shown on a long press on any back button). More details at:
    /// https://sarunw.com/posts/what-should-you-know-about-navigation-history-stack-in-ios14/
    @objc func swizzledViewWillAppear(_ animated: Bool) {
        if #available(iOS 14.0, *) {
            let backButton = BackBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButton
        }
        // Call the original viewWillAppear
        swizzledViewWillAppear(animated)
    }
}

class BackBarButtonItem: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        get {
            return super.menu
        }
        set {
            // Don't set the menu here
            // super.menu = menu
        }
    }
}

struct HSCFBaseViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            GSDA_ContainerForMenuController_GSD()
        }
    }
}
