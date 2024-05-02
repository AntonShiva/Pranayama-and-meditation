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
    
    @Binding  var isShowingBreath: Bool
    
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
    
    @State var startPausLabel = "Старт"
    
    @State private var isPaused = false
    
    @State private var timerLabel = "" // Начальное значение для текстовой метки
    // Счетчик для отображения текущего этапа дыхания
    @State private var count = 1
    
    //    _______________________
    
    @State var currentIndex = 0
    @State var timeRemaining: Int = 1
    
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    
    @State var isTimerRunning = false
   
    @State var cycle = 0 // Добавляем переменную для хранения текущего цикла
    
    //    ________________
    
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
    
    // Alert флаг
    @State private var alertShow = false
    // Обновление вью
    @State private var refreshView = false
    
    // Счетчик времени дыхательной сессии
    @State private var elapsedTimer: Timer?
    // Секунды
    @State private var elapsedSeconds: Int = 0
    //Минтуты
    @State private var elapsedMinutes: Int = 0
    
    
   var body: some View {
        ZStack{
            
            Color(hex: 0xBDFFFD)
                .ignoresSafeArea()
            
            VStack {
                
                // Отображение циклов дыхания
                HStack(spacing: 50.0) {
                    VStack{
                        Text("\(cycle)")
                            .font(.title)
                            .foregroundColor(.cyan)
                        
                        Text("Цикл")
                            .font(.title2)
                            .foregroundColor(.cyan)
                    }
                    Text(elapsedMinutes == 0 ? "\(elapsedSeconds) " : "\(elapsedMinutes):\(String(format: "%02d", elapsedSeconds))")
                        .font(.title2)
                        .foregroundColor(.cyan)
                }
                
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
                    .frame(width: 300, height: 300, alignment: .center)
                 
                    // Отображение таймера в цветке
                    BreathAnimationView(timeRemaining: $timeRemaining)
                        .opacity( isTimerRunning ? 1 : 0)
                }
                // присвоение значений для цветка из массива
                .onAppear(perform: {
                    inhaleTime = Double(selectedValues[0])
                    pauseTimeVdoh = Double(selectedValues[1])
                    exhaleTime = Double(selectedValues[2])
                    pauseTimeVidoh = Double(selectedValues[3])
                })
               // запуск анимации с задержкой в 4 сек
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        if !alertShow {
                            showBreatheView = true
                            timerLabel = "Вдох"
                            // Проигрываем звуковой эффект на каждый счет
                            metronomePlayer.playInhaleAndTickSounds(sound: "inhale")
                            
                            if showBreatheView{
                                performAnimations()
                            }
                            
                            isTimerRunning = true
                            if selectedValues.contains(where: { $0 > 0 }) {
                                isTimerRunning = true
                                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            }
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
                                    
                                    handleTimerTick() 
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
                        
                        // Отображение кастомного алерта
                        if alertShow {
                            AlertView(alertShow: $alertShow, isShowingBreath: $isShowingBreath, start: $start, startTimerCount: $startTimerCount, cycle: $cycle, refreshView: $refreshView) 
                        }
                    }
                    
                })
                
              
                
                if showBreatheView {
  
                    // Текстовая метка для отображения этапа дыхания
                    Text(timerLabel)
                        .font(.title)
                        .foregroundColor(.cyan)
                        .blur(radius: alertShow ? 0.1 : 0)
                    // Применение анимации для изменения прозрачности текста
                    
                        .padding(.bottom, 100.0)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration:1.5)))
                } else {
                    Text("Старт")
                        .font(.title)
                        .foregroundColor(.cyan)
                        .blur(radius: alertShow ? 3 : 0)
                    // Применение анимации для изменения прозрачности текста
                    
                        .padding(.bottom, 100.0)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration:1.5)))
                }
                
                
              HStack{
                   
                    Button(action: {
                        stopAnimations()
                        isTimerRunning = false
                       currentIndex = 0
                        timeRemaining = 1
                        
                        startPausLabel = "На паузе"
                        self.timer.upstream.connect().cancel()
                        metronomePlayer.stopSound()
                        alertShow = true
                        
                        metronomePlayer.stopSound()
                        start = false
                        self.startTimer.upstream.connect().cancel()
                        countTimer = 0
                        startTimerCount = 0
                        
                        // Остановка таймера отсчета секунд и минут
                            stopElapsedTimer()
                    }, label: {
                        Text("Пауза")
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
                   
                   
                    
                 .frame(width: 130)
                    
                }
              .blur(radius: alertShow ? 2 : 0)
            }
           
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                startElapsedTimer()
            }
        }
        .onDisappear {
            stopElapsedTimer()
        }
        .id(refreshView) // Добавление .id для перезагрузки представления
        
    }
    
  // Запуск счетчика времени дыхательной сессии
    private func startElapsedTimer() {
        elapsedTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedSeconds += 1
            if elapsedSeconds == 60 {
                elapsedSeconds = 0
                elapsedMinutes += 1
            }
        }
    }
    // Остановка счетчика времени дыхательной сессии
    private func stopElapsedTimer() {
        elapsedTimer?.invalidate()
        elapsedTimer = nil
    }
    
    
    // Функция для обработки события при тике таймера
    private func handleTimerTick() {
        if isTimerRunning && timeRemaining < selectedValues[currentIndex] {
            timeRemaining += 1
            metronomePlayer.playSound(sound: "tick_metronome_low", type: "mp3")
            
        } else {
            currentIndex += 1
            if currentIndex >= selectedValues.count {
                cycle += 1
                currentIndex = 0
            }
            timeRemaining = 1

            if currentIndex == 0 || currentIndex == 2 {
                timerLabel = currentIndex == 0 ? "Вдох" : "Выдох"
                
                metronomePlayer.playInhaleAndTickSounds(sound: currentIndex == 0 ? "inhale" : "exhale")
            }
            // Проверяем специальные случаи
            else if currentIndex == 1 && selectedValues[1] == 0 {
                // Пропускаем задержку на вдохе, если второе значение равно нулю
                currentIndex += 1
                timerLabel = "Выдох"
                metronomePlayer.playInhaleAndTickSounds(sound: "exhale")
            } else if currentIndex == 3 && selectedValues[3] == 0 {
                // Пропускаем последнее значение, если четвертое значение равно нулю
                currentIndex = 0
                cycle += 1
                timerLabel = "Вдох"
                metronomePlayer.playInhaleAndTickSounds(sound: "inhale")
            } else if selectedValues[1] == 0 && selectedValues[3] == 0 {
                // Проходим только по первому и третьему элементам массива, если оба значения равны нулю
                currentIndex += 2
                timerLabel = "Вдох"
                metronomePlayer.playInhaleAndTickSounds(sound: "inhale")
            } else if currentIndex == 1 && selectedValues[1] > 0 {
                // Воспроизводим звук задержки после вдоха, если второе значение больше нуля
                timerLabel = "Здаержка"
                metronomePlayer.playInhaleAndTickSounds(sound: "hold")
               
            } else if currentIndex == 3 && selectedValues[3] > 0 {
                // Воспроизводим звук задержки после выдоха, если четвертое значение больше нуля
                timerLabel = "Задержка"
                metronomePlayer.playInhaleAndTickSounds(sound: "hold")
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
        }
        
       // Таймер для переключения на выдох после заданного времени вдоха
        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTimeVdoh, repeats: false) { _ in
            
            ghostSize = GlobalBreathSettings.ghostMaxSize
            ghostBlur = 0.5
            ghostOpacity = 0.8
           // Таймер для настройки анимации "призраков"
            Timer.scheduledTimer(withTimeInterval: exhaleTime * 0.2, repeats: false) { _ in
                withAnimation(.easeOut(duration: exhaleTime * 0.3)) {
                    ghostBlur = 15
                    ghostOpacity = 0.2
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

// Предварительный просмотр анимации дыхания
struct BreathAnimation_Previews: PreviewProvider {
    static var previews: some View {
 Carusel()
    }
}

