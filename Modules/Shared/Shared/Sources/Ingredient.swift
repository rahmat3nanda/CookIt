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
    
    var icon: String {
        return switch self {
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
    
    var name: String { return rawValue.capitalized }
}
