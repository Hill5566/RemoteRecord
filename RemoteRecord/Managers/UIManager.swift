//
//  UIManager.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2021/5/24.
//

import UIKit

class UIManager: NSObject {
    
    static var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    static var loginStoryboard:UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    static var mainStoryboard:UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func switchToLogin() {
        keyWindow?.rootViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginVC")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = storyboard.instantiateViewController(identifier: "BLEConnectVC")
    }
    
    static func switchToBLEConnectVC() {
        keyWindow?.rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "BLEConnectVC")
    }
}
