//
//  FileListVC.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2021/5/27.
//

import UIKit

class FileListVC: UIViewController {

    var fileList:[FileListModel] = []
     
    @IBAction func backClick(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fileList = UserDefaultManager.default.fileListModel
        
    }
    

}

extension FileListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = fileList[indexPath.row].toDateFormat()
        
        return cell
    }
    
    
    
    
}
