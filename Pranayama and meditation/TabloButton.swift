//
//  TabloButton.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 09.04.2024.
//

import SwiftUI

struct TabloButton: View {
    var body: some View {
        VStack {
            Button(action: {
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: 80, height: 80)
                    Circle()
                        .stroke(style: .init(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                        .frame(width: 85, height: 85)
                    Text("5")
                        .foregroundColor(.white)
                        .font(.title3)
                }
                .foregroundColor(.gray)
            })
            Text("Вдох")

        }

    }
}

#Preview {
    TabloButton()
}
