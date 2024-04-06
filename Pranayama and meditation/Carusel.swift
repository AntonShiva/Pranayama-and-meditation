//
//  Carusel.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 05.04.2024.
//

import SwiftUI

struct Carusel: View {
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State var activeIndex: Int = 0
    
   
    
    var body: some View {
        
        ZStack {
            ForEach(store.items) { item in
                
                // article view
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        
                   Image(item.title)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(20)
                }
                .frame(width: 250, height: 350)
                
                .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
                .opacity(1.0 - abs(distance(item.id)) * 0.3 )
                .offset(x: myXOffset(item.id), y: 0)
                .zIndex(1.0 - abs(distance(item.id)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                        snappedItem = draggingItem
                        
                        //Get the active Item index
                        self.activeIndex = store.items.count + Int(draggingItem)
                        if self.activeIndex > store.items.count || Int(draggingItem) >= 0 {
                            self.activeIndex = Int(draggingItem)
                        }
                        print(self.activeIndex)
                    }
                }
        )
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
        return sin(angle) * 200
    }
}

#Preview {
    Carusel()
}






