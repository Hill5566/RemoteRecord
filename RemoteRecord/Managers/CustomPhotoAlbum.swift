//
//  CustomPhotoAlbum.swift
//  EverFocus
//
//  Created by Hill Lin on 2021/5/6.
//
import Photos
import UIKit

class CustomPhotoAlbum {
    
    static let shared = CustomPhotoAlbum()
    
    func saveImage(image: UIImage, deviceName:String) {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let timeStampFileName = "\(Int(Date().timeIntervalSince1970))"
        let fileURL = documentsDirectory.appendingPathComponent(timeStampFileName)
        
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        do {
            try data.write(to: fileURL)

            addMediaFileList(timeStampFileName: timeStampFileName)

        } catch let error {
            print("error saving file with error", error)
        }
    }
    
    func deleteImage(fileName:String) {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
                
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                
                deleteMediaFileList(fileName: fileName)
                
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
    }
    
    func addMediaFileList(timeStampFileName:String) {
        var mediaInfo = UserDefaultManager.default.fileListModel
        mediaInfo.append(FileListModel(timeStampFileName: timeStampFileName))
        UserDefaultManager.default.fileListModel = mediaInfo
    }
    
    func deleteMediaFileList(fileName:String) {
        let mediaInfo = UserDefaultManager.default.fileListModel
        let m = mediaInfo.filter{$0.timeStampFileName != fileName}
        UserDefaultManager.default.fileListModel = m
    }
    
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
    
}
