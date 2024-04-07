//
//  BreathingCycleSettingView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 07.04.2024.
//

import SwiftUI

struct BreathingCycleSettingView: View {
    
    @State var second = [Int](1...90)
    
    @State var indexBasic1: Int = 2
    @State var indexBasic2: Int = 2
    @State var indexBasic3: Int = 2
    @State var indexBasic4: Int = 2
    
    
    
    @State var selectedValue1 = 3
    @State var selectedValue2 = 3
    @State var selectedValue3 = 3
    @State var selectedValue4 = 3
    var body: some View {
        VStack {
            Text("Вдох на \(selectedValue1) сек.")
                .font(.system(size: 18))
            
                SwiftUIWheelPicker($indexBasic1, items: $second) { value in
                    
                    GeometryReader { reader in
                        HStack{
                            Text("\(value)")
                               
                                .font(.system(size: 25))
                                .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                        }
                        
                    }
                    
                }
                .onValueChanged { newValue in
                    selectedValue1 = newValue
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
            
            .frame(width:280, height: 50, alignment: .center)
       
            
            Text("Задержака на вдохе \(selectedValue2) сек.")
                .font(.system(size: 18))
            
            SwiftUIWheelPicker($indexBasic2, items: $second) { value in
                
                GeometryReader { reader in
                   
                    Text("\(value)")
                        .font(.system(size: 25))
                        .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                        
                }
                
            }
            
           .onValueChanged { newValue in
                    selectedValue2 = newValue
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

            .frame(width:280, height: 50, alignment: .center)
            
            Text("Выдох на \(selectedValue3) сек.")
                .font(.system(size: 18))
            
            SwiftUIWheelPicker($indexBasic3, items: $second) { value in
                
                GeometryReader { reader in
                   
                    Text("\(value)")
                        .font(.system(size: 25))
                        .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                        
                }
                
            }
            
           .onValueChanged { newValue in
                    selectedValue3 = newValue
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

            .frame(width:280, height: 50, alignment: .center)
            Text("Задержка после выдоха \(selectedValue4)  сек.")
                .font(.system(size: 18))
            
            SwiftUIWheelPicker($indexBasic4, items: $second) { value in
                
                GeometryReader { reader in
                   
                    Text("\(value)")
                        .font(.system(size: 25))
                        .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                        
                }
                
            }
            
           .onValueChanged { newValue in
                    selectedValue4 = newValue
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

            .frame(width:280, height: 50, alignment: .center)
        }
        
    }
}

#Preview {
    BreathingCycleSettingView()
}
