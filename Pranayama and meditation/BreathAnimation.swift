//
//  BreathAnimation.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 19.04.2024.
//
import Foundation
import SwiftUI

// Расширение для инициализации цвета на основе шестнадцатеричного значения
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

// Структура для хранения глобальных переменных и функций
struct GlobalSettings {
    // Функция для создания цвета на основе RGB значений
    static func createColors(_ red: Double, _ green: Double, _ blue: Double) -> Color {
        Color(red: red / 255, green: green / 255, blue: blue / 255)
    }

    // Начальный и конечный цвета градиента для петалей
    static let gradientStart = Color(hex: 0x38f5ff)
    static let gradientEnd = Color.cyan

    // Градиент и маска для цветов градиента
    static let gradient = LinearGradient(gradient: Gradient(colors: [gradientStart, .cyan, gradientEnd]), startPoint: .top, endPoint: .bottom)
    static let maskGradient = LinearGradient(gradient: Gradient(colors: [.black]), startPoint: .top, endPoint: .bottom)

    // Размеры для петалей
    static let maxSize: CGFloat = 140
    static let minSize: CGFloat = 80

    // Количество петалей и углы для их расположения
    static let numberOfPetals = 5
    static let bigAngle = 360 / numberOfPetals
    static let smallAngle = bigAngle / 2

    // Максимальные и минимальные размеры для "прозрачных" петалей
    static let ghostMaxSize: CGFloat = maxSize * 0.99
    static let ghostMinSize: CGFloat = maxSize * 0.95
}

// Представление для петалей
private struct Petals: View {
    let size: CGFloat       // Размер петалей
    let inhaling: Bool      // Флаг для индикации вдоха

    var isMask = false      // Флаг для маски

    var body: some View {
        let petalsGradient = isMask ? GlobalSettings.maskGradient : GlobalSettings.gradient // Градиент для петалей

        // ZStack для позиционирования петалей
        ZStack {
            ForEach(0..<GlobalSettings.numberOfPetals) { index in
                petalsGradient
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .mask(
                        Circle()
                            .frame(width: size, height: size)
                            .offset(x: inhaling ? size * 0.5 : 20)
                            .rotationEffect(.degrees(Double(GlobalSettings.bigAngle * index)))
                    )
                    .blendMode(isMask ? .normal : .screen)
            }
        }
    }
}

// Представление для анимации дыхания
struct BreathAnimation: View {
    
    // Время для вдоха, выдоха и паузы
    private let inhaleTime: Double = 5
    private let exhaleTime: Double = 5
    private let pauseTimeVdoh: Double = 0
    private let pauseTimeVidoh: Double = 0

    
    @State private var size = GlobalSettings.minSize                      // Размер петалей
    @State private var inhaling = false                    // Флаг для индикации вдоха

    @State private var ghostSize = GlobalSettings.ghostMaxSize            // Размер петалей "призраков"
    @State private var ghostBlur: CGFloat = 0              // Размытие петалей "призраков"
    @State private var ghostOpacity: Double = 0            // Прозрачность петалей "призраков"
    @State var showBreatheView: Bool = false
    
    var body: some View {
        
        VStack {
            // ZStack для позиционирования элементов анимации
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
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
                        .rotationEffect(.degrees(Double(GlobalSettings.smallAngle)))
                        .opacity(inhaling ? 0.8 : 0.6)
                }
                .rotationEffect(.degrees(Double(inhaling ? GlobalSettings.bigAngle : -GlobalSettings.smallAngle)))
                .drawingGroup()
            }
         
            
            Button(action: {
                showBreatheView.toggle()
                if showBreatheView{
                    performAnimations()
                }
            }, label: {
                Text("Старт")
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.75) )
                    .padding(.vertical,15)
                    .frame(maxWidth: .infinity)
                    .background {
                       
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.cyan.gradient)
                    }
            })
            .frame(width: 250)
            .padding()
        }
        
    }

    // Функция для выполнения анимаций
    private func performAnimations() {
        // Анимация вдоха
        withAnimation(.easeInOut(duration: inhaleTime)) {
            inhaling = true
            size = GlobalSettings.maxSize
        }

        // Таймер для переключения на выдох после заданного времени вдоха
        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTimeVdoh, repeats: false) { _ in
            ghostSize = GlobalSettings.ghostMaxSize
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
                size = GlobalSettings.minSize
                ghostSize = GlobalSettings.ghostMinSize
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

