//
//  Recipe.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation

public enum Recipe: String, Codable {
    case grilledCheese
    case tomatoSoup
    case baconOmelette
    case bltSandwich
    case friedRice
    case spicyMeatDish
    case cheesyMeatball
    case ultimateFriedRice
    case legendaryFeast

    public var ingredients: [Ingredient] {
        switch self {
        case .grilledCheese: [.bread, .cheese]
        case .tomatoSoup: [.tomato, .garlic]
        case .baconOmelette: [.bacon, .egg, .cheese]
        case .bltSandwich: [.bread, .bacon, .tomato, .lettuce]
        case .friedRice: [.rice, .meat, .garlic, .egg]
        case .spicyMeatDish: [.meat, .chili, .garlic]
        case .cheesyMeatball: [.meat, .cheese, .tomato, .garlic]
        case .ultimateFriedRice: [.rice, .meat, .bacon, .chili, .egg, .garlic]
        case .legendaryFeast: [.bread, .cheese, .tomato, .meat, .bacon, .lettuce, .chili, .rice, .garlic, .egg]
        }
    }

    public var tier: Tier {
        switch self {
        case .grilledCheese, .tomatoSoup, .baconOmelette, .bltSandwich:
            return .common
        case .friedRice, .spicyMeatDish, .cheesyMeatball:
            return .rare
        case .ultimateFriedRice:
            return .epic
        case .legendaryFeast:
            return .legendary
        }
    }
    
    public var image: String { rawValue.capitalized }
    
    public var name: String {
        switch self {
        case .grilledCheese: "Grilled Cheese"
        case .tomatoSoup: "Tomato Soup"
        case .baconOmelette: "Bacon Omelette"
        case .bltSandwich: "BLT Sandwich"
        case .friedRice: "Fried Rice"
        case .spicyMeatDish: "Spicy Meat Dish"
        case .cheesyMeatball: "Cheesy Meatball"
        case .ultimateFriedRice: "Ultimate Fried Rice"
        case .legendaryFeast: "Legendary Feast"
        }
    }
}
