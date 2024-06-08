//
//  IndicatorButtonView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 12.04.2024.
//

import SwiftUI

struct IndicatorButtonView: View {
  
      let value: Int
      let action: () -> Void
            
      var body: some View {
                Button(action: action) {
                    ZStack {
                        Circle()
                            .stroke(style: .init(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                            .frame(width: 50, height: 50)
                        Text("\(value)")
                            .foregroundColor(.cyan)
                            .font(.system(size: 30))
                    }
                    .foregroundColor(.cyan)
                }
            }
}


