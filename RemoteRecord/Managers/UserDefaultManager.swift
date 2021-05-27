//
//  UserDefaultManager.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2021/5/24.
//

import UIKit

let userDefault = UserDefaultManager.default

class UserDefaultManager: NSObject {
    static let `default` = UserDefaultManager()
    
    var autoLogin: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "autoLogin") }
        get { return UserDefaults.standard.bool(forKey: "autoLogin") }
    }
    
    var email: String {
        set { UserDefaults.standard.set(newValue, forKey: "email") }
        get {
            guard let t = UserDefaults.standard.string(forKey: "email") else { return "" }
            return t
        }
    }
    
    var passowrd: String {
        set { UserDefaults.standard.set(newValue, forKey: "passowrd") }
        get { guard let t = UserDefaults.standard.string(forKey: "passowrd") else { return "" }
            return t
        }
    }
    
    func setAutoLogin(_ autoLogin:Bool, email:String = "", password:String = "") {
        self.autoLogin = autoLogin
        if autoLogin {
            self.email = email
            self.passowrd = password
        } else {
            self.email = ""
            self.passowrd = ""
        }
    }
    
    var fileListModel: [FileListModel] {
        set {
            let data = try! JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: "FileListModel")
        }
        get {
            if let d = UserDefaults.standard.data(forKey: "FileListModel") {
              let stored = try! JSONDecoder().decode([FileListModel].self, from: d)
              return stored
            } else {
                return []
            }
        }
    }
}
class FileListModel:Codable {

    var timeStampFileName:String = ""
    
    init(timeStampFileName:String) {
        self.timeStampFileName = timeStampFileName
    }
    
    func toDateFormat() -> String {
        
        guard let ts = Double(timeStampFileName) else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " yyyy-MM-dd HH:mm:ss"
        let d = Date(timeIntervalSince1970: ts)
        return dateFormatter.string(from: d)
    }
}
