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
    
    @AppStorage("indexVimHof") var indexBasics  = [29, 4, 29, 29]
    @AppStorage("selectedValuesVimHof") var selectedValuesVimHof: [Int] = [30,5,30,30]
    
    var body: some View {
        VStack {
            WheelPickerView(selectedIndex: $indexBasics[0], values: self.vdohVidoh, selectedValue: $selectedValuesVimHof[0], text: "Колличество вдохов - выдохов \(self.selectedValuesVimHof[0]) ")
            WheelPickerView(selectedIndex: self.$indexBasics[1], values: self.vdohVidoh, selectedValue: self.$selectedValuesVimHof[1], text: "Темп дыхания \(self.selectedValuesVimHof[1]) сек.")
            WheelPickerView(selectedIndex: self.$indexBasics[2], values: self.vdohVidoh, selectedValue: self.$selectedValuesVimHof[2], text: "Задержка на выдохе \(self.selectedValuesVimHof[2]) сек.")
            WheelPickerView(selectedIndex: self.$indexBasics[3], values: self.vdohVidoh, selectedValue: self.$selectedValuesVimHof[3], text: "Задержка на вдохе \(self.selectedValuesVimHof[3]) сек.")
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
