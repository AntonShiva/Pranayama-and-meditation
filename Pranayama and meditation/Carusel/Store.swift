//
//  Store.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 06.04.2024.
//

import SwiftUI
class Store: ObservableObject {
    @Published var items: [Item] = [Item(id: 0, title: "0", opisanie: "Настроить свой ритм"),
                                    Item(id: 1, title: "1", opisanie: ""),
                                    Item(id: 2, title: "2", opisanie: ""),
                                    Item(id: 3, title: "3", opisanie: "Практика Вима Хофа")]
    
   
  

}
