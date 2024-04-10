//
//  BreathingCycleSettingView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 07.04.2024.
//

import SwiftUI

struct BreathingCycleSettingView: View {
    
    @State var vdohVidoh = [Int](1...180)
    @State var zaderjka = [Int](0...180)
    
    @State var indexBasic1: Int = 4
    @State var indexBasic2: Int = 0
    @State var indexBasic3: Int = 4
    @State var indexBasic4: Int = 0
    
    
    
    @State var selectedValue1 = 5
    @State var selectedValue2 = 5
    @State var selectedValue3 = 5
    @State var selectedValue4 = 5
    var body: some View {
        VStack {
            WheelPickerView(selectedIndex: $indexBasic1, values: vdohVidoh, selectedValue: $selectedValue1, text: "Вдох на \(selectedValue1) сек.")
            WheelPickerView(selectedIndex: $indexBasic2, values: zaderjka, selectedValue: $selectedValue2, text: "Задержка на вдохе \(selectedValue2) сек.")
            WheelPickerView(selectedIndex: $indexBasic3, values: vdohVidoh, selectedValue: $selectedValue3, text: "Выдох на \(selectedValue3) сек.")
            WheelPickerView(selectedIndex: $indexBasic4, values: zaderjka, selectedValue: $selectedValue4, text: "Задержка после выдоха \(selectedValue4) сек.")
        }
    }
}

#Preview {
    BreathingCycleSettingView()
}
