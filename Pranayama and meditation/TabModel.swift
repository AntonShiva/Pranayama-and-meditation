//
//  TabModel.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 29.03.2024.
//

import Foundation
import SwiftUI
enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case home, game, apps, movie
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .game:
            return "gamecontroller.fill"
        case .apps:
            return "square.stack.3d.up.fill"
        case .movie:
            return "play.tv.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .game:
            return "Games"
        case .apps:
            return "Apps"
        case .movie:
            return "Movies"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .indigo
        case .game:
            return .pink
        case .apps:
            return .orange
        case .movie:
            return .teal
        }
    }
}
