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
    }
    
    static func switchToBLEConnectVC() {
        keyWindow?.rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "BLEConnectVC")
    }
    static func switchToRecordVideoVC() {
        keyWindow?.rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "RecordVideoViewController")
    }
}
