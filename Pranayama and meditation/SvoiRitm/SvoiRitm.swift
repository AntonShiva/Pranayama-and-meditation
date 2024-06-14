//
//  SvoiRitm.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 06.06.2024.
//

import SwiftUI
import AVFoundation

struct SvoiRitm: View {
    
    @AppStorage("selected")  var selectedValues  = [5, 0, 5, 0]
    
    // флаг для появление настроек дыхания
    @AppStorage("isShowing") private var isShowing = false
    // Флаг для своего дыхательного ритма
     @State private var isShowingBreath = false
    
    
    
    var body: some View {
   
        VStack{
           VStack(alignment: .center) {
                Image(decorative: "1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                    .clipShape(.rect(cornerRadius: 20))
                
                
            }
            
            .padding(.top, 20.0)
            .padding(.bottom, 20)
            .padding(.horizontal, 40.0)
            .frame(maxWidth: .infinity, alignment: .top)
            
  
            
            Spacer()
            
            VStack {
                Text("Настроить свой ритм")
                    .foregroundStyle(.cyan)
                .font(.system(size: 25))
            }
            
            Spacer()
            
            VStack {
                TabloPusk(isShowing: $isShowing, selectedValues: $selectedValues)
                    .padding(.top, 15.0)
            }
            
            
            Spacer()
            
            
            VStack {
                Spacer()
                HStack(alignment: .bottom){
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
            .padding(.bottom, 15)
               
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
            
        }
        .padding(.top, 20.0)
       
        .sheet(isPresented: $isShowing) {
                   VStack {
                       Text("Настройте свой ритм")
                           .padding(.top, 40.0)
                           .foregroundStyle(.cyan)
                           .font(.system(size: 25))
                       
                       BreathingCycleSettingView(isShowing: $isShowing, selectedValues: $selectedValues)
                           .padding(.top, 40.0)
                       
                       Spacer()
                       
                   }
                   .padding(.top, 15.0)
                   .presentationDetents([.large])
               }
        .fullScreenCover(isPresented: $isShowingBreath) {
            
            BreathAnimation(isShowingBreath: $isShowingBreath)
                .ignoresSafeArea()
        }
    
    }
}

#Preview {
   HomeView()
}
