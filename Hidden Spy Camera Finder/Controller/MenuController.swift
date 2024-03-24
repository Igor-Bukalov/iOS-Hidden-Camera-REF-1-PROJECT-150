//
//  Controller.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit

enum MenuController: Int, CaseIterable {
    case scan, antiSpy, btRadar, settings
    
    var titleScene: String {
        switch self {
        case .scan: return "Scanning"
        case .antiSpy: return "Anti-spy"
        case .btRadar: return "Bluetooth"
        case .settings: return "Settings"
        }
    }
    
    var menuTitle: String {
        switch self {
        case .scan: return "Scan"
        case .antiSpy: return "Anti-spy"
        case .btRadar: return "BT Radar"
        case .settings: return "Settings"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .scan: UIImage(named: "tab-scan")
        case .antiSpy: UIImage(named: "tab-anti-spy")
        case .btRadar: UIImage(named: "tab-bt-radar")
        case .settings: UIImage(named: "tab-settings")
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .scan: UIImage(named: "tab-scan-selected")
        case .antiSpy: UIImage(named: "tab-anti-spy-selected")
        case .btRadar: UIImage(named: "tab-bt-radar-selected")
        case .settings: UIImage(named: "tab-settings-selected")
        }
    }
    
    var controllerWithNavigation: UIViewController {
        HSCFBaseNavigationController(rootViewController: controller)
    }
    
    var controller: UIViewController {
        var vc = UIViewController()
        switch self {
        case .scan: vc = HSCFScanViewController()
        case .antiSpy: vc = AntiSpyViewController()
        case .btRadar: vc = BTRadarViewController()
        case .settings: vc = HSCFSettingsViewController()
        }
        vc.title = titleScene
        return vc
    }
}
