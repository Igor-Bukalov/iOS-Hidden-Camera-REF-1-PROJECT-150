// 
// Created by Evgeniy Bruchkovskiy on 2023, All rights reserved.
//

import Foundation

extension UserDefaults {
    class var termsOfServiceAlertIsShowed: Bool {
        get { UserDefaults.standard.bool(forKey: #function) }
        set { UserDefaults.standard.set(newValue, forKey: #function) }
    }
}
