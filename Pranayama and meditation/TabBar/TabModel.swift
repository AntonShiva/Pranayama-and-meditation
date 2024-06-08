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
    
    case svoiRejim, vimHof, yogaNidra, history
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .svoiRejim:
            return "house.fill"
        case .vimHof:
            return "calendar.badge.clock"
        case .yogaNidra:
            return "info.square"
        case .history:
            return "gear"
        }
    }
    
    var title: String {
        switch self {
        case .svoiRejim:
            return "Home"
        case .vimHof:
            return "Chart"
        case .yogaNidra:
            return "Info"
        case .history:
            return "Settings"
        }
    }
    
    var color: Color {
        switch self {
        case .svoiRejim:
            return .cyan
        case .vimHof:
            return .cyan
        case .yogaNidra:
            return .cyan
        case .history:
            return .cyan
        }
    }
}
