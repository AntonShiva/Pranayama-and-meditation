//
//  HomeVeiw.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 08.06.2024.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab: Tab = .svoiRejim
    @State private var direction: CGFloat = 1
    @Namespace private var animation
    
    var body: some View {
       ZStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                   ZStack {
                        if selectedTab == .svoiRejim {
                        
                                   SvoiRitm()
                                      .padding(.bottom, 50)
                                       .frame(width: geometry.size.width, height: geometry.size.height)

                                       .transition(Twirl())
                        }
                        if selectedTab == .vimHof {
                          
                                VimHofView()
                                    .padding(.bottom, 50)
                                    .frame(width: geometry.size.width, height: geometry.size.height)

                                    .transition(Twirl())
                            }
                        
                        if selectedTab == .yogaNidra {
                            withAnimation(.easeInOut(duration: 3)){
                                YogaNidra()
                                    .padding(.bottom, 50)
                                    .frame(width: geometry.size.width, height: geometry.size.height)

                                    .transition(Twirl())
                            }
                        }
                        if selectedTab == .history {
                        
                               History()
                                .padding(.bottom, 50)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .transition(Twirl())
                    }
                }
                    Spacer()
                    
                    TabBarView(selectedTab: $selectedTab, direction: $direction)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .animation(.easeInOut(duration: 0.6), value: selectedTab)
            }
        }
        .padding(.bottom, 80)
    }
}

#Preview {
    HomeView()
}

struct Twirl: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .scaleEffect(phase.isIdentity ? 1 : 0.5)
            .opacity(phase.isIdentity ? 1 : 0)
            .blur(radius: phase.isIdentity ? 0 : 10)
//            .rotationEffect(
//                .degrees(
//                    phase == .willAppear ? 5 :
//                        phase == .didDisappear ? -5 : .zero
//                )
//            )
            .rotation3DEffect(.degrees(phase == .willAppear ? 140 : phase == .didDisappear ? -140 : .zero ), axis: (x: 0, y: 1, z: 0))
            .brightness(phase == .willAppear ? 1 : 0)
    }
}
