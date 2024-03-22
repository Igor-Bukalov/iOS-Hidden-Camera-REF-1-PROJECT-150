//
//  InitialViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import SwiftUI

class InitialViewController: HSCFBaseViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNextScene()
    }
    
    private func showNextScene() {
        let tabbarController = GSDA_ContainerForMenuController_GSD()
        tabbarController.modalPresentationStyle = .fullScreen
        tabbarController.modalTransitionStyle = .crossDissolve
        present(tabbarController, animated: true)
    }
}
