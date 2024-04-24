//
//  BreathAnimationView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 24.04.2024.
//

import SwiftUI

struct BreathAnimationView: View {
    @Binding var timeRemaining: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .frame(width: 70, height: 70)
                .foregroundColor(.white)
            
            Text("\(timeRemaining)")
                .fontWeight(.heavy)
                .font(.system(size: 36))
                .foregroundColor(.mint)
        }
    }
}
