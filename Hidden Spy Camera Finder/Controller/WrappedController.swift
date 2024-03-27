//
//  WrappedController.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 26.03.2024.
//

import UIKit

enum WrappedController {
    case scanDetails, tutorial, deviceDistance, antiSpy

    var viewController: UIViewController {
        let vc: UIViewController
        switch self {
        case .scanDetails:
            vc = ScanDetailsViewController()
        case .tutorial:
            vc = TutorialViewController()
        case .deviceDistance:
            vc = DeviceDistanceViewController()
        case .antiSpy:
            vc = AntiSpyDetailsViewController()
        }
        vc.title = self.title
        return vc
    }
    
    private var title: String {
        switch self {
        case .scanDetails: return "Details"
        case .tutorial: return "Tutorial"
        case .deviceDistance: return "Device"
        case .antiSpy: return "Details"
        }
    }
}
