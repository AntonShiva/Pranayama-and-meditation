//
//  GlobalBreathSettings.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 21.04.2024.
//

import Foundation
import SwiftUI

// Структура для хранения глобальных переменных и функций
struct GlobalBreathSettings {
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
