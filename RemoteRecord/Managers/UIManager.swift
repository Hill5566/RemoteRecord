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
    static func getCustomCameraVC() -> CustomCameraVC {
        let vc = mainStoryboard.instantiateViewController(identifier: "CustomCameraVC")
        vc.modalPresentationStyle = .fullScreen
        return vc as! CustomCameraVC
    }
    
    static func switchToLogin() {
        keyWindow?.rootViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginVC")
    }
    
    static func switchToBLEConnectVC() {
        keyWindow?.rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "BLEConnectVC")
    }
}
