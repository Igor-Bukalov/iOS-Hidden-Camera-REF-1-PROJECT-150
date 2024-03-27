//
//  CBManagerState+Ext.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 26.03.2024.
//

import UIKit
import CoreBluetooth

extension CBManagerState {
    var alertContent: (title: String, subtitle: String, actionTitle: String) {
        let commonTitle = "OK"
        switch self {
        case .unknown, .resetting, .unsupported, .poweredOn:
            return ("Status: \(self.statusTitle)", self.statusMessage, commonTitle)
        case .unauthorized, .poweredOff:
            return ("Status: \(self.statusTitle)", self.statusMessage, "Open Settings")
        @unknown default:
            return ("Status: unknown", "An unknown error occurred", commonTitle)
        }
    }
    
    private var statusTitle: String {
        switch self {
        case .unknown: return "Unknown"
        case .resetting: return "Resetting"
        case .unsupported: return "Unsupported"
        case .unauthorized: return "Unauthorized"
        case .poweredOff: return "Powered Off"
        case .poweredOn: return "Powered On"
        @unknown default: return "Unknown"
        }
    }
    
    private var statusMessage: String {
        switch self {
        case .resetting: return "Try again later"
        case .unauthorized: return "Access to Bluetooth is required. Please update settings."
        case .poweredOff: return "Bluetooth is off. Please enable it in settings."
        default: return ""
        }
    }
    
    func performActionIfNeeded() {
        switch self {
        case .unauthorized, .poweredOff:
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        default: break
        }
    }
}
