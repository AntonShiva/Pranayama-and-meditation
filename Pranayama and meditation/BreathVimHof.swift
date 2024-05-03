//
//  BreathVimHof.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 02.05.2024.
//

import SwiftUI

struct BreathVimHof: View {
    
    
    // Время для вдоха, выдоха и паузы
    @State private var inhaleTime: Double = 2.2
    @State private  var  exhaleTime: Double = 2.2
    @State private  var  pauseTimeVdoh: Double = 0
    @State private  var  pauseTimeVidoh: Double = 0
    
    // Отображение кол-во вдохов
    @State var timeRemaining: Int = 1
    @State var isTimerRunning = false
    
    @State private var size = GlobalBreathSettings.minSize                      // Размер петалей
    @State private var inhaling = false                    // Флаг для индикации вдоха
    
    @State private var ghostSize = GlobalBreathSettings.ghostMaxSize            // Размер петалей "призраков"
    @State private var ghostBlur: CGFloat = 0              // Размытие петалей "призраков"
    @State private var ghostOpacity: Double = 0
    
    // Инициализация экземпляра класса MetronomePlayer
    var metronomePlayer = MetronomePlayer()
    
    // Старт
  // отображение стартового отсчета
    @State var start = true
    // счетчкик стартового таймера
    @State var countTimer = 0
    // отображаемое число отсчета
    @State var startTimerCount: Int = 4
    // Start timer
    @State var startTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
   
    @State var timer = Timer.publish(every: 0.0, on: .main, in: .common).autoconnect()
    
    // Alert флаг
    @State private var alertShow = false
    // Обновление вью
    @State private var refreshView = false
    
    // Флаг для остановки анимации
    @State private var shouldRunAnimation = true
    // Колличество вдохов-выдохов на одну дыхательную сессию
    @State private var numberOfBreathsExhaled = 3
    
    
    var body: some View {
        ZStack {
           ZStack {
                // Петали "призраки" при выдохе
                Petals(size: ghostSize, inhaling: inhaling)
                    .blur(radius: ghostBlur)
                    .opacity(ghostOpacity)
                
                // Маска для петалей, чтобы избежать 'прыжка' цвета при выдохе
                Petals(size: size, inhaling: inhaling, isMask: true)
                
                // Перекрывающиеся петали
                Petals(size: size, inhaling: inhaling)
                Petals(size: size, inhaling: inhaling)
                    .rotationEffect(.degrees(Double(GlobalBreathSettings.smallAngle)))
                    .opacity(inhaling ? 0.8 : 0.6)
                
            }
            
            .rotationEffect(.degrees(Double(inhaling ? GlobalBreathSettings.bigAngle : -GlobalBreathSettings.smallAngle)))
            .drawingGroup()
            .frame(width: 300, height: 300, alignment: .center)
            
            // Отображение таймера в цветке
            BreathAnimationView(timeRemaining: $timeRemaining)
                .opacity( isTimerRunning ? 1 : 0)
          
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                if !alertShow {
                   
                        
                        // Проигрываем звуковой эффект на каждый счет
                        //                    metronomePlayer.playSound(sound: "breathing-4sec", type: "mp3")
                        
                        
                        performAnimations()
                        
                        
                        isTimerRunning = true
                        // Проигрываем звуковой эффект на каждый счет
                        metronomePlayer.playSound(sound: "breathing-4sec", type: "mp3")
                        timer = Timer.publish(every: 4.4, on: .main, in: .common).autoconnect()
                  
                }
            }
          
        })
        // отображение таймера с логикой
        .overlay(content: {
           ZStack{
                Circle()
                    .stroke(style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                if isTimerRunning {
                    BreathAnimationView(timeRemaining: $timeRemaining)
                        .opacity(0)
                    
                        .onReceive(timer) { _ in
                            if timeRemaining < numberOfBreathsExhaled {
                                // Проигрываем звуковой эффект на каждый счет
                                metronomePlayer.playSound(sound: "breathing-4sec", type: "mp3")
                            }
                                timeRemaining += 1
                            
                            if timeRemaining == numberOfBreathsExhaled {
                                
                                metronomePlayer.stopSound()
                                stopAnimations()
                                
                               
                               
                            }
                          
                            if timeRemaining == numberOfBreathsExhaled {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    isTimerRunning = false
                                    timeRemaining = 1
                                }
                            }
                       }
                    
                } else {
                    // Табло старт обратный отсчет
                    ZStack{
                        Image(systemName: "atom")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                        // Табло старт
                        if start{
                        Text("\(startTimerCount)")
                            .onReceive(startTimer) { _ in
                                if startTimerCount != 0 {
                                    countTimer += 1
                                    startTimerCount = 4 - Int(countTimer)
                             
                                    if startTimerCount >= 1 {
                                        metronomePlayer.playSound(sound: "tick_metronome_low", type: "mp3")
                                    }
                                    if startTimerCount == 0 {
                                        metronomePlayer.stopSound()
                                        start = false
                                        self.startTimer.upstream.connect().cancel()
                                        countTimer = 0
                                        startTimerCount = 0
                                        //                                showStart = false
                                    }
                                }
                                
                            }
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .foregroundColor(Color(hex: 0x05C3F0))
                    }
                    }
                }
                
            
            }
            
        })
    }
    // Функция для остановки анимации
    private func stopAnimations() {
        // Сбрасываем все состояния и останавливаем таймеры
        inhaling = false
        size = GlobalBreathSettings.minSize
        ghostSize = GlobalBreathSettings.ghostMaxSize
        ghostBlur = 0
        ghostOpacity = 0
       
        self.timer.upstream.connect().cancel()
        shouldRunAnimation = false // Устанавливаем shouldRunAnimation в false
    }
    
    // Функция для выполнения анимаций
    private func performAnimations() {
        guard shouldRunAnimation else { return } // Проверяем shouldRunAnimation
        
        // Анимация вдоха
        withAnimation(.easeInOut(duration: inhaleTime)) {
            inhaling = true
            size = GlobalBreathSettings.maxSize
        }
        
       // Таймер для переключения на выдох после заданного времени вдоха
        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTimeVdoh, repeats: false) { _ in
            
            ghostSize = GlobalBreathSettings.ghostMaxSize
            ghostBlur = 0.5
            ghostOpacity = 0.8
           // Таймер для настройки анимации "призраков"
            Timer.scheduledTimer(withTimeInterval: exhaleTime * 0.2, repeats: false) { _ in
                withAnimation(.easeOut(duration: exhaleTime * 0.3)) {
                    ghostBlur = 10
                    ghostOpacity = 0.1
                }
            }
            
           // Анимация выдоха
            withAnimation(.easeInOut(duration: exhaleTime)) {
                inhaling = false
                size = GlobalBreathSettings.minSize
                ghostSize = GlobalBreathSettings.ghostMinSize
               
                
            }
        }
        
        // Таймер для повторной анимации после завершения одного цикла
        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTimeVdoh + exhaleTime + pauseTimeVidoh, repeats: false) { _ in
            
            performAnimations()
            
        }
    }
}

#Preview {
    BreathVimHof()
}
