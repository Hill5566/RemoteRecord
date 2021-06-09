//
//  LoginVC.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2021/5/23.
//

import UIKit
import PodioKit
import ProgressHUD
import SynologyKit

class LoginVC: UIViewController {

    private var client: SynologyClient?
    
    @IBAction func loginNASClick(_ sender: UIButton) {
        
        client = SynologyClient(host: "61.142.9.96", port: 5000, enableHTTPS: false)
        client?.login(account: "daniel", passwd: "ngt360") { [weak self] response in
            switch response {
            case .success(let authRes):
                self?.client?.updateSessionID(authRes.sid)
                self?.handleLoginSuccess()
                print(authRes.sid)
            case .failure(let error):
                print(error.description)
            }
        }
    }
    private func handleLoginSuccess() {
        uploadImage()
    }
    
    private func uploadImage() {
        
        guard let client = client else { return }

        guard let url = Bundle.main.url(forResource: "IMG_5469", withExtension: "MOV"),
            let data = try? Data(contentsOf: url) else {
            return
        }
        
        var options = SynologyClient.UploadOptions()
        options.overwrite = true
        options.modificationTime = Int64(Date().timeIntervalSince1970*1000)
        client.upload(data: data, filename: "IMG_5469.MOV", destinationFolderPath: "/Production", createParents: true, options: options, progressHandler: { (progress) in
            print("progress: \(progress.fractionCompleted)")
        }) { result in
            switch result {
            case .failure(let error):
                print(error.description)
            case .success(let response):
                print("uploaded:\(response)")
            }
        }
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var autoLoginButton: UIButton!
    
    @IBAction func autoLoginButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        angelblue065@gmail.com
//        podio0000
        
        if userDefault.autoLogin {
            emailTextField.text = userDefault.email
            passwordTextField.text = userDefault.passowrd
            autoLoginButton.isSelected = true
            print(userDefault.email, userDefault.passowrd)
            login(userDefault.email, userDefault.passowrd)
        }
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if email != "" && password != "" {
            login(email, password)
        }
    }
    
    func login(_ email:String?, _ password:String?)  {
        
        ProgressHUD.show(pleaseWait)
        
        PodioKit.authenticateAsUser(withEmail: email, password: password)!.onSuccess({ (response) in
            
            ProgressHUD.showSucceed()
            
            print("Successfully authenticated")
            
            userDefault.setAutoLogin(self.autoLoginButton.isSelected, email: email ?? "", password: password ?? "")
            
            UIManager.switchToBLEConnectVC()

        })?.onError({ (error) in
            
            print("onError authenticated", error?.localizedDescription)
            
            guard let error = error else {
                ProgressHUD.showFailed()
                return
            }
            ProgressHUD.showFailed(error.localizedDescription)
        })
    }
    
    func ttttttt() {

        let templateID = 25645012 // You find the ID if the template you create in Podio Platform Console
        
//        let filter = PKTItemFilters().withValue("Open", forKey: "status")
//
//        PKTItem.fetchItemsInSpaceWithID(spaceID, templateID: templateID, offset: 0, limit: 20, sortBy: "created_on", descending: true, filters:filters)
//          .onSuccess { (openBugs: [PKTItem]!) in
//            println("Found \(count(openBugs)) open bugs")
//          }
//          .onError { error in
//            println("Failed to fetch bugs: \(error.localizedDescription)")
//          }
    }
}

