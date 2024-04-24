//
//  MetronomePlayer.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 24.04.2024.
//

import SwiftUI
import AVFoundation

class MetronomePlayer {
    private var audioPlayer: AVAudioPlayer?
    
    func stopSound() {
            audioPlayer?.stop()
        }

    func playSound(sound: String, type: String) {
        DispatchQueue.global().async {
            guard let soundURL = Bundle.main.url(forResource: sound, withExtension: type) else { return }
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                self.audioPlayer?.play()
            } catch {
                print("Ошибка проигрывания звука")
            }
        }
    }
}
