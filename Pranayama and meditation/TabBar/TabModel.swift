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
            return "calendar.badge.clock"
        case .apps:
            return "info.square"
        case .movie:
            return "gear"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .game:
            return "Chart"
        case .apps:
            return "Info"
        case .movie:
            return "Settings"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .cyan
        case .game:
            return .cyan
        case .apps:
            return .cyan
        case .movie:
            return .cyan
        }
    }
}
