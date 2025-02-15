//
//  Ingredient.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation

public enum Ingredient: String, Codable, CaseIterable {
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
    
    public var image: String { "\(rawValue.capitalized)" }
    
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

extension Array where Element == Ingredient {
    func sortedByTierAndName() -> [Ingredient] {
        sorted {
            if $0.tier == $1.tier {
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
            return $0.tier.rate < $1.tier.rate
        }
    }
    
    func toCard() -> [Card] {
        reduce(into: []) { result, item in
            if let index = result.firstIndex(where: { $0.name == item.name }) {
                result[index].count += 1
            } else {
                result.append(.from(item))
            }
        }
    }
}
