//
//  NastroikiVimHof.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 06.05.2024.
//

import SwiftUI

struct NastroikiVimHof: View {
    @State var vdohVidoh = Array(1...180)
   
    
    @State private var isShowing: Bool = true
    
    @State private var indexBasics  = [29, 4, 29, 29]
    @State private var selectedValues: [Int] = [30,5,30,30]
    
//    @Binding var dailyRate: [Int]
    
    var body: some View {
        VStack {
            WheelPickerView(selectedIndex: $indexBasics[0], values: self.vdohVidoh, selectedValue: $selectedValues[0], text: "Колличество вдохов - выдохов \(self.selectedValues[0]) ")
            WheelPickerView(selectedIndex: self.$indexBasics[1], values: self.vdohVidoh, selectedValue: self.$selectedValues[1], text: "Темп дыхания \(self.selectedValues[1]) сек.")
            WheelPickerView(selectedIndex: self.$indexBasics[2], values: self.vdohVidoh, selectedValue: self.$selectedValues[2], text: "Задержка на выдохе \(self.selectedValues[2]) сек.")
            WheelPickerView(selectedIndex: self.$indexBasics[3], values: self.vdohVidoh, selectedValue: self.$selectedValues[3], text: "Задержка на вдохе \(self.selectedValues[3]) сек.")
            Button {
                withAnimation {
                    isShowing.toggle()
                }
            } label: {
                Text("Сохранить")
                    .foregroundStyle(.cyan)
                    .font(.system(size: 17))
            }
            .frame(width: 120.0, height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cyan, lineWidth: 2)
            )
            .padding(.top, 35)
        }
    }
}

#Preview {
    NastroikiVimHof()
}
