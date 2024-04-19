//
//  BreathCounterView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 16.04.2024.
//

import SwiftUI

struct BreathCounterView: View {
    
    @State private var animateBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animateBonusRemaining = bonusRemaining
        withAnimation(.linear(duration: bonusTimeRemaining)) {
            animateBonusRemaining = 0
        }
    }
    // percentage of the bonus time remaining
    var bonusRemaining: Double {
        (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    
    // длительность таймера
    var bonusTimeLimit: TimeInterval = 7
    
    // how much time left before the bonus opportunity runs out
    var bonusTimeRemaining: TimeInterval {
        max(0, bonusTimeLimit - pastFaceUpTime)
    }
  
    var pastFaceUpTime: TimeInterval = 0
    
    var body: some View {
        VStack {
            Indicator(
                startAngle: Angle(degrees: 0 - 90),
                endAngle: Angle(degrees: -animateBonusRemaining * 360 - 90),
                clockwise: false
                   
            )
            .foregroundColor(Color.cyan)
            .padding(5)
            .opacity(0.4)
            .frame(width: 60, height: 60)
            .onAppear {
                startBonusTimeAnimation()
            }
        }
        .padding()
    
    }
}

#Preview {
    BreathCounterView()
}
