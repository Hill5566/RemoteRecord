//
//  Extensions.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2021/5/23.
//
import UIKit

let PODIO_KEY = "remoterecord"
let PODIO_SECRET = "Q2Ztmzg6bUTSbnD8Iukf2G0S35nS16m5SH9DgLnKslVe8sAQ4KvEKrWmvUhf7TgC"
let PODIO_APP_ID = 25645012

var volume: Float = 0.5
let pleaseWait = "Please wait..."
let change_Root_VC = "change_Root_VC"

extension Double {
    func toInt() -> Int {
        return Int(self)
    }
}

extension FileManager {
    func getMovieNames() -> [FileListModel] {
        var videos:[FileListModel] = []
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            for item in tmpDirectory {
                if item.contains("tempMovie") {
                    print(item)
                    videos.append(FileListModel(timeStampFileName: item.replacingOccurrences(of: "tempMovie", with: "")))
                }
                
            }
        } catch {
           //catch the error somehow
        }
        return videos
    }
    func getVideoPathUrl(fileName:String) -> String? {
        let urlString:String? = nil
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            for item in tmpDirectory {
                if item.contains("tempMovie") {
                    print(item)
                    if item.contains(fileName) {
                        return tmpDirURL.absoluteString + item
                    }
                }
                
            }
        } catch {
           //catch the error somehow
        }
        return urlString
    }
}
