//
//  Configurations.swift
//  template
//
//  Created by Alexander N on 14.07.2023.
//

import Foundation
import CoreText

enum Configurations_HSCF {
    static let subFontUrl = Bundle.main.url(forResource: "sub", withExtension: "ttf")!
    static let adjustToken = "hfg1t85ufqbk"
    
    static let pushwooshToken = "6C58D-86648"
    static let pushwooshAppName = "test"
    
    static let termsLink: String = "https://www.google.com"
    static let policyLink: String = "https://www.google.com"
    
    static let mainSubscriptionID = "main_sub"
    static let mainSubscriptionPushTag = "MainSubscription"
    static let unlockContentSubscriptionID = "unlockOne"
    static let unlockContentSubscriptionPushTag = "SecondSubscription"
    static let unlockFuncSubscriptionID = "unlockTwo"
    static let unlockFuncSubscriptionPushTag = "SecondSubscription"
    static let unlockerThreeSubscriptionID = "unlockThree"
    static let unlockerThreeSubscriptionPushTag = "FourSubscription"
    
    static let subscriptionSharedSecret = "253336a4821b43d0af174241a9a85f90"
    
    static func getSubFontName_HSCF() -> String {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        let fontPath = Configurations_HSCF.subFontUrl.path as CFString
        let fontURL = CFURLCreateWithFileSystemPath(nil, fontPath, CFURLPathStyle.cfurlposixPathStyle, false)
        
        guard let fontDataProvider = CGDataProvider(url: fontURL!) else {
            return ""
        }
        
        if let font = CGFont(fontDataProvider) {
            if let postScriptName = font.postScriptName as String? {
                return postScriptName
            }
        }
        
        return ""
    }
    
}


enum ConfigurationMediaSub_hscf {
    static let nameFileVideoForPhone = "phone"
    static let nameFileVideoForPad = "pad"
    static let videoFileType = "mp4"
}
