//
//  AlertViewVimHof.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 03.05.2024.
//

import SwiftUI

struct AlertViewVimHof: View {
    @Binding var startTimerCount: Int
    // Обновление вью
     @Binding var refreshView: Bool
    
    @Binding var alertShow: Bool
    @Binding var start: Bool
   
    // флаг показать скрыть вью вим хофа
    @Binding var isShowingBreathVimHof: Bool
    

 
        var body: some View {
            ZStack {
                VStack {

                    
                    VStack (spacing: 10)  {
                        Text("Пауза")
                            .font(.system(size: 36))
                            .foregroundStyle(.white)
                            .bold()
                        
                   Text("Прежде чем продолжить сессию сделайте глубокий вдохов и полный выдох")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .padding([.leading, .bottom], 10.0)
                            .foregroundStyle(.white)
                            
                    }
                    
                    HStack(spacing: 20.0) {
                        // Кнопка стоп
                        ZStack {
                            Button {
                                alertShow = false
                                isShowingBreathVimHof = false
                            } label: {
                                HStack (spacing: 12) {
                                    Text("Стоп")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.white)
                                        .bold()
                                    Image(systemName: "stop.fill")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 25))
                                }
                                .padding(14)
                            }
                        }
                        .frame(width: 120, height: 45)
                        .background(.blue.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .shadow(radius: 10)
                        // Кнопка старт
                        ZStack {
                            Button {
                                start = true
                                startTimerCount = 4
                                alertShow = false
//                               
                                refreshView.toggle()
                            } label: {
                                HStack (spacing: 12) {
                                    Text("Старт")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.white)
                                        .bold()
                                    Image(systemName: "play.fill")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 25))
                                }
                                .padding(14)
                            }
                        }
                        .frame(width: 120, height: 45)
                        .background(.blue.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .shadow(radius: 10)
                        
                    }
                }
                .padding(20.0)
            }
            .background(.cyan)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .frame(width: 350, height: 250, alignment: .center)
            .shadow(radius: 15)
        }
    
}

//#Preview {
//    AlertViewVimHof()
//}
