//
//  Store.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 06.04.2024.
//

import SwiftUI
class Store: ObservableObject {
    @Published var items: [Item]
    
   
    
    // dummy data
    init() {
        items = []
        for i in 0...3 {
            let new = Item(id: i, title: "\(i)")
            items.append(new)
        }
    }
}
