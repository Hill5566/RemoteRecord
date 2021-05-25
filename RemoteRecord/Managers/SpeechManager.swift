//
//  SpeechManager.swift
//  RecordVideo
//
//  Created by Hill Lin on 2021/5/25.
//

import UIKit
import AVFoundation

class SpeechManager {
    
    static let speecher = AVSpeechSynthesizer()
    
    static func speak(_ text:String) {
        let speechText = AVSpeechUtterance(string: text)
        speechText.volume = 0.5
        speechText.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        speecher.speak(speechText)
    }
}
