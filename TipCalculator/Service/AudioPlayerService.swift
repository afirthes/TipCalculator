//
//  AudioPlayerService.swift
//  TipCalculator
//
//  Created by Afir Thes on 20.02.2023.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudoPlayer: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
