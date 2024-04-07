//
//  ContentView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 29.03.2024.
//

import SwiftUI

let backgroundColor = Color.init(white: 0.92)

struct ContentView: View {
   @State private var isShowing = false
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            VStack() {
                Carusel()
                    .padding(50)
                    .onTapGesture {
                        isShowing = true
                    }
                    .sheet(isPresented: $isShowing) {
                        VStack {
                            BreathingCycleSettingView()
                        }
                        
                        .presentationDetents([.medium])
                    }
                Spacer()
                TabBarView()
             
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
