//
//  MetronomePlayer.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 24.04.2024.
//

import SwiftUI
import AVFoundation

class MetronomePlayer {
    private var audioEngine = AVAudioEngine()
    private var inhalePlayer = AVAudioPlayerNode()
    private var tickPlayer = AVAudioPlayerNode()
    
    init() {
          do {
              try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
              try AVAudioSession.sharedInstance().setActive(true)
          } catch {
              print("Failed to activate audio session: \(error)")
          }
      }
    
    func stopSound() {
        audioEngine.stop()
        inhalePlayer.stop()
        tickPlayer.stop()
    }
    
    func playInhaleAndTickSounds(sound: String) {
        DispatchQueue.global().async { 
            guard let inhaleSoundURL = Bundle.main.url(forResource: sound, withExtension: "mp3"),
                  let tickSoundURL = Bundle.main.url(forResource: "tick_metronome_high", withExtension: "mp3") else {
                print("Ошибка: Файлы звуков не найдены")
                return
            }
            
            do {
                let inhaleAudioFile = try AVAudioFile(forReading: inhaleSoundURL)
                let tickAudioFile = try AVAudioFile(forReading: tickSoundURL)
                
                // Останавливаем все предыдущие звуки
                self.stopSound()
                
                // Подключаем узлы к аудио движку
                let audioEngineSession = AVAudioSession.sharedInstance()
                try audioEngineSession.setCategory(.playback)
                self.audioEngine.attach(self.inhalePlayer)
                self.audioEngine.attach(self.tickPlayer)
                
                // Подключаем узлы к движку
                let inhaleAudioFormat = inhaleAudioFile.processingFormat
                let tickAudioFormat = tickAudioFile.processingFormat
                
                self.audioEngine.connect(self.inhalePlayer, to: self.audioEngine.mainMixerNode, format: inhaleAudioFormat)
                self.audioEngine.connect(self.tickPlayer, to: self.audioEngine.mainMixerNode, format: tickAudioFormat)
                
                // Загружаем аудиофайлы в плееры
                self.inhalePlayer.scheduleFile(inhaleAudioFile, at: nil)
                self.tickPlayer.scheduleFile(tickAudioFile, at: nil)
                
                // Стартуем движок
                try audioEngineSession.setActive(true)
                self.audioEngine.prepare()
                try self.audioEngine.start()
                self.inhalePlayer.play()
                self.tickPlayer.play()
            } catch {
                print("Ошибка проигрывания звуков: \(error.localizedDescription)")
            }
        }
    }
    func playSound(sound: String, type: String) {
        DispatchQueue.global().async {
            guard let soundURL = Bundle.main.url(forResource: sound, withExtension: type) else { return }
            do {
                let audioFile = try AVAudioFile(forReading: soundURL)
                let audioFormat = audioFile.processingFormat
                
                // Создаем новый AVAudioPlayerNode для воспроизведения звука
                let audioPlayer = AVAudioPlayerNode()
                self.audioEngine.attach(audioPlayer)
                self.audioEngine.connect(audioPlayer, to: self.audioEngine.mainMixerNode, format: audioFormat)
                
                // Планируем воспроизведение аудиофайла
                audioPlayer.scheduleFile(audioFile, at: nil)
                
                // Запускаем аудиодвижок и воспроизводим звук
                try self.audioEngine.start()
                audioPlayer.play()
            } catch {
                print("Ошибка проигрывания звука: \(error.localizedDescription)")
            }
        }
    }
}
