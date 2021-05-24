//
//  LoginVC.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2021/5/23.
//

import UIKit
import PodioKit
import ProgressHUD


class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        login()
    }
    
    @IBAction func login(_ sender: UIButton) {
        login()
    }
    
    func login()  {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        ProgressHUD.show(pleaseWait)
        
        PodioKit.authenticateAsUser(withEmail: email, password: password)!.onSuccess({ (response) in
            
            ProgressHUD.showSucceed()
            
            print("Successfully authenticated")
            
            NotificationCenter.default.post(name: Notification.Name(change_Root_VC), object: nil)

        })?.onError({ (error) in
            
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

