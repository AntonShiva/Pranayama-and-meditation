//
//  CarouselViewChild.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 02.04.2024.
//

import SwiftUI

struct CarouselViewChild: View, Identifiable {
    var id: Int
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}

