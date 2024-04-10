//
//  TabloPusk.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 09.04.2024.
//

import SwiftUI

struct TabloPusk: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Button(action: {
                    isShowing = true
                }, label: {
                    ZStack {
    //                    Circle()
    //                        .frame(width: 80, height: 80)
                        Circle()
                            .stroke(style: .init(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                            .frame(width: 60, height: 60)
                        Text("5")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                    }
                    .foregroundColor(.gray)
                })
                Text("Вдох")
                    .font(.system(size: 13))
                    
            }
            
            VStack {
                Button(action: {
                }, label: {
                    ZStack {
    //                    Circle()
    //                        .frame(width: 80, height: 80)
                        Circle()
                            .stroke(style: .init(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                            .frame(width: 60, height: 60)
                        Text("2")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                    }
                    .foregroundColor(.gray)
                })
                VStack{
                    Text("Задержка")
                        .font(.system(size: 13))
                      
                    
                    
                }
           }
            
            VStack {
                Button(action: {
                }, label: {
                    ZStack {
    //                    Circle()
    //                        .frame(width: 80, height: 80)
                        Circle()
                            .stroke(style: .init(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                            .frame(width: 60, height: 60)
                        Text("5")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                    }
                    .foregroundColor(.gray)
                })
                Text("Выдох")
                    .font(.system(size: 13))
                    
            }
            
            VStack {
                Button(action: {
                }, label: {
                    ZStack {
    //                    Circle()
    //                        .frame(width: 80, height: 80)
                        Circle()
                            .stroke(style: .init(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                            .frame(width: 60, height: 60)
                        Text("3")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                    }
                    .foregroundColor(.gray)
                })
                Text("Задержка")
                    .font(.system(size: 13))
                    
            }
            
        }
    }
}

