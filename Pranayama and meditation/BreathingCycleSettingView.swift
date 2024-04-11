//
//  BreathingCycleSettingView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 07.04.2024.
//


import SwiftUI


struct BreathingCycleSettingView: View {
    
    @State var vdohVidoh = Array(1...180)
    @State var zaderjka = Array(0...180)
    
    @Binding var isShowing: Bool
    
    @AppStorage("indexBasics")  var indexBasics  = [4, 0, 4, 0]
    @AppStorage("selectedValues")  var selectedValues  = [5, 0, 5, 0]
    
//    @Binding var dailyRate: [Int]
    
    var body: some View {
        VStack {
            WheelPickerView(selectedIndex: self.$indexBasics[0], values: self.vdohVidoh, selectedValue: self.$selectedValues[0], text: "Вдох на \(self.selectedValues[0]) сек.")
            WheelPickerView(selectedIndex: self.$indexBasics[1], values: self.zaderjka, selectedValue: self.$selectedValues[1], text: "Задержка на вдохе \(self.selectedValues[1]) сек.")
            WheelPickerView(selectedIndex: self.$indexBasics[2], values: self.vdohVidoh, selectedValue: self.$selectedValues[2], text: "Выдох на \(self.selectedValues[2]) сек.")
            WheelPickerView(selectedIndex: self.$indexBasics[3], values: self.zaderjka, selectedValue: self.$selectedValues[3], text: "Задержка после выдоха \(self.selectedValues[3]) сек.")
            Button {
                withAnimation {
                    isShowing.toggle()
                }
            } label: {
                Text("Сохранить")
                    .foregroundStyle(.cyan)
                    .font(.system(size: 17))
            }
            .frame(width: 100.0, height: 35)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cyan, lineWidth: 2)
            )
            .padding(.top, 35)
        }
    }
}

#Preview {
    Carusel()
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
