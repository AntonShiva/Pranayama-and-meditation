//
//  VimHofView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 06.06.2024.
//

import SwiftUI

struct VimHofView: View {
        //Данные настроек дыхания
    @AppStorage("selectedValuesVimHof") var selectedValuesVimHof: [Int] = [30,4,30,30]
        
        // флаг для появления настроек дыхания вима хофа
        @AppStorage("isShowingVimHof") var isShowingVimHof = false
        // Флаг для дыхательрной практики Вима Хофа
        @State private var isShowingBreathVimHof = false
        
        var body: some View {
            VStack{
                
                Text("Практика Вима Хофа")
                    .foregroundStyle(.cyan)
                    .font(.system(size: 25))
                
                Spacer()
                HStack{
                    
                    ZStack {
                        Circle()
                            .stroke(style: .init(lineWidth: 3.5, lineCap: .round, lineJoin: .round))
                            .frame(width: 70, height: 70)
                        
                        Text("\(selectedValuesVimHof[0])")
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
                            isShowingVimHof = true
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
            .sheet(isPresented: $isShowingVimHof ) {
                NastroikiVimHof(isShowing: $isShowingVimHof)
            }
            .fullScreenCover(isPresented: $isShowingBreathVimHof) {
                BreathVimHof(isShowingBreathVimHof: $isShowingBreathVimHof)
                    .ignoresSafeArea()
            }
        }
    }



//#Preview {
//    TabBarView(selectedTab: <#Binding<Tab>#>)
//}
