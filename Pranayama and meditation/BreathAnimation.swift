//
//  BreathAnimation.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 19.04.2024.
//
import Foundation
import SwiftUI



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
  
    
    @State private var isPaused = false
    
    @State private var timerLabel = "" // Начальное значение для текстовой метки
    // Счетчик для отображения текущего этапа дыхания
       @State private var count = 1
    
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
        .onAppear(perform: {
            inhaleTime = Double(selectedValues[0])
            pauseTimeVdoh = Double(selectedValues[1])
            exhaleTime = Double(selectedValues[2])
            pauseTimeVidoh = Double(selectedValues[3])
        })
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
            }
            .overlay(content: {
                ProgressBarButtonView(value: "\(count)")
                    

            })
            
            
           // Текстовая метка для отображения этапа дыхания
                 Text(timerLabel)
                .font(.title)
                .foregroundColor(.cyan)
                .padding()
                     // Применение анимации для изменения прозрачности текста
                     .opacity(showBreatheView ? 1.0 : 0.001)
                     .animation(.easeInOut) // Анимация появления текста без задержки
                     .onAppear {
                         timerLabel = "Вдох" // Установка начального значения текстовой метки
                     }
                              
            
            HStack{
                Button(action: {
                    stopAnimations()
                }, label: {
                    Text("Стоп")
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
                }, label: {
                    Text("Старт")
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
            .padding(.bottom, 120.0)
            
            
            
        }
        .offset(x: 0 ,y: 90)

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
        
//            // Обновление счетчика в соответствии с текущим этапом дыхания
//            Timer.scheduledTimer(withTimeInterval: 1 , repeats: inhaleTimeBool) { _ in
//                count += 1
//                if count > Int(inhaleTime){
//                   count = 1
//                    inhaleTimeBool = false
//                    
//            }
//                
//        }
//        
        
        
        
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

