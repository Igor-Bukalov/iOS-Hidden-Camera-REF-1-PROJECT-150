//
//  BaseNavigationController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import SwiftUI

class HSCFBaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc
    func back() {}
}

struct HSCFBaseNavigationController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            HSCFBaseNavigationController()
        }
    }
}
