//
//  AppDelegate.swift
//  RemoteRecord
//
//  Created by Hill Lin on 2020/12/7.
//

import UIKit
import AVFoundation
import MediaPlayer

var volume: Float = 0.5

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let audioSession = AVAudioSession.sharedInstance()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(volume, animated: false)
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "volumeChanged")))
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        volume = audioSession.outputVolume
        if volume == 0 { volume += 0.1 } else if volume == 1 { volume -= 0.1 }
        try! audioSession.setActive(true)
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        audioSession.removeObserver(self, forKeyPath: "outputVolume")
    }
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

