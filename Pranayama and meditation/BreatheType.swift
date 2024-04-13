//
//  BreatheType.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 13.04.2024.
//

import Foundation
import SwiftUI

// MARK: Type Model And Sample Types
struct BreatheType: Identifiable,Hashable{
    var id: String = UUID().uuidString
    var title: String
    var color: Color
}

let sampleTypes: [BreatheType] = [
    .init(title: "Anger", color: .mint),
    .init(title: "Irritation", color: .brown),
    .init(title: "Sadness", color: .purple)
]
