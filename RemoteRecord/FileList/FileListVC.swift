//
//  FileListVC.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2021/5/27.
//

import UIKit

class FileListVC: UIViewController {

    var fileList:[FileListModel] = []
     
    @IBOutlet weak var mTableView: UITableView!
    
    @IBAction func backClick(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fileList = FileManager().getMovieNames()
        sortFileList()
        
        mTableView.reloadData()
    }
    
    func sortFileList() {
        fileList.sort { f1, f2 in
            if let f1ts = Double(f1.timeStampFileName.replacingOccurrences(of: ".mp4", with: "")), let f2ts = Double(f2.timeStampFileName.replacingOccurrences(of: ".mp4", with: "")) {
                return f1ts > f2ts
            } else {
                return false
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let fileName = fileList[indexPath.row]
        let urlString:String? = FileManager().getVideoPathUrl(fileName: fileName.timeStampFileName)
        
        let vc = UIManager.getVideoViewerVC()
        vc.videoUrl = URL(string: urlString ?? "")
        
        present(vc, animated: true, completion: nil)
    }
}
