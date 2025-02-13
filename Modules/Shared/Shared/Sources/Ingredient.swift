//
//  Ingredient.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation

public enum Ingredient: String, Codable {
    case bread
    case cheese
    case tomato
    case meat
    case garlic
    case egg
    case bacon
    case lettuce
    case chili
    case rice
    
    public var icon: String {
        switch self {
        case .bread: "🍞"
        case .cheese: "🧀"
        case .tomato: "🍅"
        case .meat: "🥩"
        case .garlic: "🧄"
        case .egg: "🍳"
        case .bacon: "🥓"
        case .lettuce: "🥬"
        case .chili: "🌶️"
        case .rice: "🍚"
        }
    }
    
    public var name: String { rawValue.capitalized }
    
    public var tier: Tier {
        switch self {
        case .bread: .common
        case .cheese: .common
        case .tomato: .common
        case .meat: .rare
        case .garlic: .epic
        case .egg: .rare
        case .bacon: .common
        case .lettuce: .common
        case .chili: .rare
        case .rice: .epic
        }
    }
}
