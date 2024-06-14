//
//  ContentView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 29.03.2024.
//

import SwiftUI

let backgroundColor = Color.init(white: 0.92)

struct ContentView: View {
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            VStack() {
     
               HomeView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
