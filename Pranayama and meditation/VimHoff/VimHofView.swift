//
//  VimHofView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 06.06.2024.
//

import SwiftUI
import AVFoundation

struct VimHofView: View {
        //Данные настроек дыхания
    @AppStorage("selectedValuesVimHof") var selectedValuesVimHof: [Int] = [30,4,30,30]
        
        // флаг для появления настроек дыхания вима хофа
        @AppStorage("isShowingVimHof") var isShowingVimHof = false
        // Флаг для дыхательрной практики Вима Хофа
        @State private var isShowingBreathVimHof = false
        
        var body: some View {
            
            VStack{
               VStack(alignment: .center) {
                    Image(decorative: "0")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                        .clipShape(.rect(cornerRadius: 20))
                    
                    
                }
                .padding(.top, 22.0)
                .padding(.bottom, 10)
                .padding(.horizontal, 40.0)
                
                .frame(maxWidth: .infinity, alignment: .top)

                
                Spacer()
                
                Text("Практика Вима Хофа")
                    .foregroundStyle(.cyan)
                    .font(.system(size: 25))
                    .padding(.top, 2)
                
                Spacer()
                
                VStack {
                    HStack{
                       ZStack {
                            Circle()
                                .stroke(style: .init(lineWidth: 3.5, lineCap: .round, lineJoin: .round))
                                .frame(width: 60, height: 60)
                            
                            Text("\(selectedValuesVimHof[0])")
                                .foregroundColor(.cyan)
                                .font(.system(size: 35))
                        }
                        .padding(.top, 10.0)
                        .foregroundColor(.cyan)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("циклов")
                        .foregroundStyle(.cyan)
                    .font(.system(size: 20))
                }
                
                Spacer()
                
                
                VStack {
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
                .padding(.bottom, 13)
                }
                .frame(maxWidth: .infinity, alignment: .bottom)

                
               Spacer()
                
            }
            .padding(.top, 27.0)
            .padding(.bottom, 3)
           
            
            .sheet(isPresented: $isShowingVimHof ) {
                NastroikiVimHof(isShowing: $isShowingVimHof)
            }
            .fullScreenCover(isPresented: $isShowingBreathVimHof) {
                BreathVimHof(isShowingBreathVimHof: $isShowingBreathVimHof)
                    .ignoresSafeArea()
            }
        }
    }



#Preview {
    HomeView()
}
