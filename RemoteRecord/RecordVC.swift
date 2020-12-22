//
//  RecordVC.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2020/12/14.
//

import UIKit

class RecordVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    @IBAction func tt(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }


}

extension RecordVC: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}
