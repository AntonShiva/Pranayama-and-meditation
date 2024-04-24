//
//  BreathAnimation.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 19.04.2024.
//
import Foundation
import SwiftUI
import AVFoundation


// Представление для анимации дыхания
struct BreathAnimation: View {
    
    // Время для вдоха, выдоха и паузы
    @AppStorage("inhaleTime") var inhaleTime: Double = 5
    @AppStorage("exhaleTime") var  exhaleTime: Double = 5
    @AppStorage("pauseTimeVdoh") var  pauseTimeVdoh: Double = 0
    @AppStorage("pauseTimeVidoh") var  pauseTimeVidoh: Double = 0
    
  
 
    @AppStorage("selected")  var selectedValues  = [5, 0, 5, 0]

    
    @State private var size = GlobalBreathSettings.minSize                      // Размер петалей
    @State private var inhaling = false                    // Флаг для индикации вдоха

    @State private var ghostSize = GlobalBreathSettings.ghostMaxSize            // Размер петалей "призраков"
    @State private var ghostBlur: CGFloat = 0              // Размытие петалей "призраков"
    @State private var ghostOpacity: Double = 0            // Прозрачность петалей "призраков"
    @State var showBreatheView: Bool = false
  
    @State var startPausLabel = "Начать сессию"
    
    @State private var isPaused = false
    
    @State private var timerLabel = "" // Начальное значение для текстовой метки
    // Счетчик для отображения текущего этапа дыхания
       @State private var count = 1
    
//    _______________________
    
    @State var currentIndex = 0
    @State var timeRemaining: Int = 1
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isTimerRunning = false
    @State var pauseResumeBtn = "Start"
    @State var cycle = 0 // Добавляем переменную для хранения текущего цикла
    
//    ________________
    
    // Инициализация экземпляра класса MetronomePlayer
    var metronomePlayer = MetronomePlayer()
    
    
    var body: some View {
        ZStack{
        GeometryReader{proxy in
            let size = proxy.size
            Image("BG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
                .opacity(0.1)
            // MARK: Blurrubg White Breathing
                .blur(radius:  3 , opaque: true)
              
        }
        .ignoresSafeArea()
    
        VStack {
            // ZStack для позиционирования элементов анимации
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
                
                    BreathAnimationView(timeRemaining: $timeRemaining)
                    .opacity( isTimerRunning ? 1 : 0)
            }
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
                                
                                if isTimerRunning && timeRemaining < selectedValues[currentIndex] {
                                    timeRemaining += 1
                                    // Проигрываем звуковой эффект на каждый счет
                                    metronomePlayer.playSound(sound: "tick_metronome_low", type: "mp3")
                                } else {
                                    currentIndex += 1
                                    if currentIndex >= selectedValues.count {
                                        // Если достигли конца массива, увеличиваем значение цикла и сбрасываем индекс
                                        cycle += 1
                                        currentIndex = 0
                                    }
                                    timeRemaining = 1
                                    // Проигрываем звуковой эффект на каждый счет
                                    metronomePlayer.playSound(sound: "tick_metronome_high", type: "mp3")
                                }
                            }
                    } else {
                        Image(systemName: "atom")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                }
                
            })
            
            if showBreatheView {
                // Текстовая метка для отображения этапа дыхания
                Text(timerLabel)
                    .font(.title)
                    .foregroundColor(.cyan)
               
                // Применение анимации для изменения прозрачности текста
                    
                    .animation(.easeInOut) // Анимация появления текста без задержки
                    .onAppear {
                        timerLabel = "Вдох" // Установка начального значения текстовой метки
                    }
            }else{
                Text(startPausLabel)
                    .font(.title)
                    .foregroundColor(.cyan)
                    
            }
            
            
            HStack{
                Button(action: {
                    stopAnimations()
                    isTimerRunning = false
                    pauseResumeBtn = "Start"
                    currentIndex = 0
                    timeRemaining = 1
                    cycle = 0 // Сбрасываем цикл при остановке
                    startPausLabel = "На паузе"
                    self.timer.upstream.connect().cancel()
                    metronomePlayer.stopSound()
                }, label: {
                    Text("Stop")
                        .font(.system(size: 25))
                        .foregroundColor(.white.opacity(0.75))
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.cyan.gradient)
                        }
                })
                .padding(.trailing, 5.0)
                .frame(width: 130)
                
                
                
                Button(action: {
                    showBreatheView.toggle()
                    if showBreatheView{
                        performAnimations()
                    }
                    if pauseResumeBtn == "Start" {
                        pauseResumeBtn = "Pause"
                        isTimerRunning = true
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    } else if pauseResumeBtn == "Pause" {
                        pauseResumeBtn = "Resume"
                        isTimerRunning = false
                        self.timer.upstream.connect().cancel()
                    } else {
                        pauseResumeBtn = "Pause"
                        isTimerRunning = true
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }
                }, label: {
                    Text(pauseResumeBtn)
                        .font(.system(size: 25))
                        .foregroundColor(.white.opacity(0.75))
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.cyan.gradient)
                        }
                })
                .padding(.leading, 5.0)
                .frame(width: 130)
                
            }
            
            
            
            
        }
       

    }
        
    }
    
 
    // Функция для остановки анимации
    private func stopAnimations() {
        // Сбрасываем все состояния и останавливаем таймеры
        inhaling = false
        size = GlobalBreathSettings.minSize
        ghostSize = GlobalBreathSettings.ghostMaxSize
        ghostBlur = 0
        ghostOpacity = 0
        showBreatheView = false
        timerLabel = "" // Сброс текстовой метки
        count = 1 // Сброс счетчика
    }

    // Функция для выполнения анимаций
    private func performAnimations() {
        guard showBreatheView else { return } // Проверяем условие для запуска анимации
        guard showBreatheView && !isPaused else { return }
        // Анимация вдоха
        withAnimation(.easeInOut(duration: inhaleTime)) {
           inhaling = true
            size = GlobalBreathSettings.maxSize
            timerLabel = "Вдох" // Обновление текстовой метки
        }

        // Таймер для переключения на выдох после заданного времени вдоха
        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTimeVdoh, repeats: false) { _ in
            
            ghostSize = GlobalBreathSettings.ghostMaxSize
            ghostBlur = 0
            ghostOpacity = 0.8
            

            // Таймер для настройки анимации "призраков"
            Timer.scheduledTimer(withTimeInterval: exhaleTime * 0.3, repeats: false) { _ in
                withAnimation(.easeOut(duration: exhaleTime * 0.5)) {
                    ghostBlur = 30
                    ghostOpacity = 0
                }
            }

            // Анимация выдоха
            withAnimation(.easeInOut(duration: exhaleTime)) {
                inhaling = false
                size = GlobalBreathSettings.minSize
                ghostSize = GlobalBreathSettings.ghostMinSize
                timerLabel = "Выдох" // Обновление текстовой метки
              
            }
        }
        

        // Проверяем условие для отображения метки "Задержка"
        if pauseTimeVdoh > 0 {
            // Установка метки "Задержка" после выдоха
            Timer.scheduledTimer(withTimeInterval: inhaleTime , repeats: false) { _ in
                    timerLabel = "Задержка"
            }
        }

        // Проверяем условие для отображения метки "Задержка"
        if pauseTimeVidoh > 0 {
            // Установка метки "Задержка" после выдоха
            Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTimeVdoh + exhaleTime , repeats: false) { _ in
                    timerLabel = "Задержка"
            }
        }
        
        
        
        // Таймер для повторной анимации после завершения одного цикла
        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTimeVdoh + exhaleTime + pauseTimeVidoh, repeats: false) { _ in
           
            performAnimations()
            
        }
    }
 
}

// Предварительный просмотр анимации дыхания
struct BreathAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BreathAnimation()
    }
}

