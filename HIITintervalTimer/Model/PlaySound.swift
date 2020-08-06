//
//  PlaySound.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 8/4/20.
//  Copyright © 2020 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import AVFoundation

struct PlaySound {
    
   static var player: AVAudioPlayer?
    
    static func play(with sound: String, extensionn: String = K.Sounds.soundExtension, soundOn: Bool) {
        if !soundOn {
            guard let url = Bundle.main.url(forResource: sound, withExtension: extensionn) else { return }
            do {
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                guard let player = player else { return }
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
