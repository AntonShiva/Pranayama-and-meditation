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
   
    
    private var audioEngine = AVAudioEngine()
      private var inhalePlayer = AVAudioPlayerNode()
      private var tickPlayer = AVAudioPlayerNode()
      
    
    func stopSound() {
            audioPlayer?.stop()
        audioEngine.stop()

        }
    
    func playInhaleAndTickSounds(sound: String) {
         guard let inhaleSoundURL = Bundle.main.url(forResource: sound, withExtension: "mp3"),
               let tickSoundURL = Bundle.main.url(forResource: "tick_metronome_high", withExtension: "mp3") else {
             print("Ошибка: Файлы звуков не найдены")
             return
         }
         
         do {
             let inhaleAudioFile = try AVAudioFile(forReading: inhaleSoundURL)
             let tickAudioFile = try AVAudioFile(forReading: tickSoundURL)
             
             // Останавливаем все предыдущие звуки
             stopSound()
             
             // Подключаем узлы к аудио движку
             audioEngine.attach(inhalePlayer)
             audioEngine.attach(tickPlayer)
             
             // Подключаем узлы к движку
             audioEngine.connect(inhalePlayer, to: audioEngine.mainMixerNode, format: inhaleAudioFile.processingFormat)
             audioEngine.connect(tickPlayer, to: audioEngine.mainMixerNode, format: tickAudioFile.processingFormat)
             
             // Загружаем аудиофайлы в плееры
             inhalePlayer.scheduleFile(inhaleAudioFile, at: nil)
             tickPlayer.scheduleFile(tickAudioFile, at: nil)
             
             // Стартуем движок
             try audioEngine.start()
            
                 self.inhalePlayer.play()
             
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                 
                 // Воспроизводим оба звука одновременно
                 self.tickPlayer.play()
             }
           
         } catch {
             print("Ошибка проигрывания звуков: \(error.localizedDescription)")
         }
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
