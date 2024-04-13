//
//  WheelPickerView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 10.04.2024.
//

import SwiftUI

struct WheelPickerView: View {
    @Binding var selectedIndex: Int
    var values: [Int]
    @Binding var selectedValue: Int
    var text: String

    var body: some View {
        VStack {
            Text(text)
                .foregroundStyle(.cyan)
                .font(.system(size: 18))
            
            SwiftUIWheelPicker($selectedIndex, items: values) { value in
                GeometryReader { reader in
                    Text("\(value)")
                        .font(.system(size: 20))
                        .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                        .foregroundStyle(.cyan)
                        
                }
            }
            .onValueChanged { newValue in
                selectedValue = newValue
            }
            .scrollAlpha(0.2)
            .scrollScale(0.9)
            .centerView(AnyView(
                HStack(alignment: .center, spacing: 0) {
                    Divider()
                        .frame(width: 1)
                        .background(Color.gray)
                        .padding(EdgeInsets(top: 9, leading: 0, bottom: 9, trailing: 0))
                        .opacity(0.4)
                    Spacer()
                    Divider()
                        .frame(width: 1)
                        .background(Color.gray)
                        .padding(EdgeInsets(top: 9, leading: 0, bottom: 9, trailing: 0))
                        .opacity(0.4)
                }
            ), width: .Fixed(40))
            .frame(width: 280, height: 50, alignment: .center)
        }
    }
}

