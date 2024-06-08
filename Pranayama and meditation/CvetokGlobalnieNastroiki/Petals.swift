//
//  Petals.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 21.04.2024.
//

import SwiftUI
import Foundation
// Представление для петалей

struct Petals: View {
    let size: CGFloat       // Размер петалей
    let inhaling: Bool      // Флаг для индикации вдоха

    var isMask = false      // Флаг для маски

    var body: some View {
        let petalsGradient = isMask ? GlobalBreathSettings.maskGradient : GlobalBreathSettings.gradient // Градиент для петалей

        // ZStack для позиционирования петалей
        ZStack {
            ForEach(0..<GlobalBreathSettings.numberOfPetals) { index in
                petalsGradient
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .mask(
                        Circle()
                            .frame(width: size, height: size)
                            .offset(x: inhaling ? size * 0.5 : 20)
                            .rotationEffect(.degrees(Double(GlobalBreathSettings.bigAngle * index)))
                    )
                    .blendMode(isMask ? .normal : .screen)
            }
        }
    }
}
