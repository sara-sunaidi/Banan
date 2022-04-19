//
//  File.swift
//  Banan
//
//  Created by Sara Alsunaidi on 19/04/2022.
//

import Foundation
import AVFoundation

class PlayAllSounds {
    static let sharedInstance = PlayAllSounds()
    private var player: AVAudioPlayer?

     func play(name: String) {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3")
                else { return }
        
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
        
                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
                    guard let player = player else { return }
        
                    player.play()
        
                } catch let error {
                    print(error.localizedDescription)
                }
//        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            guard let player = player else { return }
//
//            player.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
    }

    func stop() {
        player?.stop()
    }
}
