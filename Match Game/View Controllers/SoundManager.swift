//
//  SoundManager.swift
//  Match Game
//
//  Created by Jordi Farras Mañe on 26/01/2019.
//  Copyright © 2019 Jordi Farras Mañe. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    static func playSound(_ effect:SoundEffect) {
        var soundFilename = ""
        
        switch effect {
            
        case .flip:
            soundFilename = "cardflip"
        
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
            print("olaa")

            guard bundlePath != nil else {
                print("Couldn't find sound file \(soundFilename) in the bundle")
                return
            }
            
            let soundURL = URL(fileURLWithPath: bundlePath!)
            
            do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                
            audioPlayer?.play()
            }
            catch {
                print("couldn't create")
            }
        
    }
}
