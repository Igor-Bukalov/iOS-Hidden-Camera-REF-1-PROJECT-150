//
//  CBManagerState+Ext.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 26.03.2024.
//

extension UserDefaults {
    private enum Keys {
        static let hasShownTermsOfServiceAlert = "hasShownTermsOfServiceAlert"
    }
    
    class var hasShownTermsOfServiceAlert: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.hasShownTermsOfServiceAlert) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.hasShownTermsOfServiceAlert) }
    }
}
