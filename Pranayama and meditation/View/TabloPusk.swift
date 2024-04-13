//
//  TabloPusk.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 09.04.2024.
//

import SwiftUI

struct TabloPusk: View {
    @Binding var isShowing: Bool
        @Binding var selectedValues: [Int]
        
        var body: some View {
            HStack(spacing: 10) {
                ForEach(0..<selectedValues.count) { index in
                    if selectedValues[index] > 0 {
                        VStack {
                            IndicatorButtonView(value: selectedValues[index], action: {
                                isShowing = true
                            })
                            if index == 0 || index == 2 {
                                Text(index == 0 ? "Вдох" : "Выдох")
                                    .font(.system(size: 13))
                                    .foregroundColor(.blue)
                            } else  {
                                Text("Задержка")
                                    .font(.system(size: 13))
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
        }}

