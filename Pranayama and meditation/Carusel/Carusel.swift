//
//  Carusel.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 05.04.2024.
//

import SwiftUI

struct Carusel: View {
   // Флаг для своего дыхательного ритма
    @State private var isShowingBreath = false
    // Флаг для дыхательрной практики Вима Хофа
    @State private var isShowingBreathVimHof = false
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State var activeIndex: Int = 0
 
    
    @AppStorage("selected")  var selectedValues  = [5, 0, 5, 0]
    @AppStorage("isShowing") var isShowing = false

    
    var body: some View {
        VStack {
            ZStack {
                ForEach(store.items) { item in
                    
                    // article view
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                        
                        Image(item.title)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(18)
                        
                    }
                    .frame(width: 250, height: 350)
                    
                    .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
                    .opacity(1.0 - abs(distance(item.id)) * 0.3 )
                    .offset(x: myXOffset(item.id), y: 0)
                    .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                    
                    
                }
                
            }
//            .onTapGesture {
//                isShowing = true
//            }
            .sheet(isPresented: $isShowing) {
                VStack {
                    
                  
                    
                    Text("\(store.items[0].opisanie)")
                        .padding(.top, 40.0)
                        .foregroundStyle(.cyan)
                        .font(.system(size: 25))
                    
                   
                    
                    BreathingCycleSettingView(isShowing: $isShowing, selectedValues: $selectedValues)
                        .padding(.top, 40.0)
                    
                    Spacer()
                    
                }
                
                .presentationDetents([.large])
            }
            .fullScreenCover(isPresented: $isShowingBreath) {
              
                BreathAnimation(isShowingBreath: $isShowingBreath)
                    .ignoresSafeArea()
            }
            .fullScreenCover(isPresented: $isShowingBreathVimHof) {
                BreathVimHof(isShowingBreathVimHof: $isShowingBreathVimHof)
                    .ignoresSafeArea()
            }
            
            
//            .fullScreenCover(isPresented: $isShowingBreath) {
//                BreatheView()
//            }
            
            .gesture(
                DragGesture()
                    .onChanged { value in
                        draggingItem = snappedItem + value.translation.width / 100
                    }
                    .onEnded { value in
                        withAnimation {
                            draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                            draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                            snappedItem = draggingItem
                            
                            //Get the active Item index
                            self.activeIndex = store.items.count + Int(draggingItem)
                            if self.activeIndex > store.items.count || Int(draggingItem) >= 0 {
                                self.activeIndex = Int(draggingItem)
                            }
                        }
                    }
            )
            
            
          // Точечный индикатро прокрути
            CustomIndicator()
                .padding(.top, 15.0)
            
            // Отображение настройки своего ритма дыхания если отображается 3 индекс массива карусели
            if activeIndex == 3 {
                VStack{
                  Text("\(store.items[0].opisanie)")
                        .foregroundStyle(.cyan)
                        .font(.system(size: 25))
                    
                    Spacer()
                    
                    TabloPusk(isShowing: $isShowing, selectedValues: $selectedValues)
                        .padding(.top, 15.0)
                    
                
                    Spacer()
                
                
                HStack{
                    Spacer()
                    Button {
                         withAnimation {
                             isShowing = true
                         }
                    } label: {
                        Text("Настроить")
                            .foregroundStyle(.cyan)
                            .font(.system(size: 17))
                    }
                    .frame(width: 120.0, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            isShowingBreath = true
                        }
                    } label: {
                        Text("Старт")
                            .foregroundStyle(.cyan)
                            .font(.system(size: 17))
                    }
                    .frame(width: 120.0, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                    
                    Spacer()
                    
                }
                .padding(.vertical, 15.0)
                    
                    Spacer()

                }
                .padding(.top, 5.0)
                    
            }
            
            // Отображение настройки своего ритма дыхания если отображается первый индекс массива карусели
            if activeIndex == 0 {
                VStack{
                  Text("\(store.items[3].opisanie)")
                        .foregroundStyle(.cyan)
                        .font(.system(size: 25))
                    
                    Spacer()
                    HStack{
                       
                        ZStack {
                            Circle()
                                .stroke(style: .init(lineWidth: 3.5, lineCap: .round, lineJoin: .round))
                                .frame(width: 70, height: 70)
                            
                            
                            
                            Text("30")
                                .foregroundColor(.cyan)
                                .font(.system(size: 35))
                        }
                        .foregroundColor(.cyan)
                        

                        
                    }
                    
                   Text("циклов")
                        .foregroundStyle(.cyan)
                        .font(.system(size: 20))
                
                    Spacer()
                
                
                HStack{
                    Spacer()
                    Button {
                         withAnimation {
                             isShowing = true
                         }
                    } label: {
                        Text("Настроить")
                            .foregroundStyle(.cyan)
                            .font(.system(size: 17))
                    }
                    .frame(width: 120.0, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            isShowingBreathVimHof = true
                        }
                    } label: {
                        Text("Старт")
                            .foregroundStyle(.cyan)
                            .font(.system(size: 17))
                    }
                    .frame(width: 120.0, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                    
                    Spacer()
                    
                }
                .padding(.vertical, 15.0)
                    
                    Spacer()

                }
                .padding(.top, 5.0)
                    
            }
            
        }
    }
    
    @ViewBuilder
    func CustomIndicator()->some View {
        HStack(spacing: 5) {
            ForEach(store.items.reversed()) { item in
                VStack{
                                   
                    Circle()
                        .fill(activeIndex == Int(item.id) ? .cyan : .gray.opacity(0.5))
                    
                        .frame(width: activeIndex == Int(item.id) ? 10 : 6, height: activeIndex == Int(item.id) ? 10 : 6)
                    
                }
            }
        }
        .animation(.easeInOut, value: activeIndex)
      
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
        return sin(angle) * 200
    }
}

#Preview {
    ContentView()
}






