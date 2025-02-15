//
//  Card.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import Foundation
import UIKit

class Card {
    let rawValue: String
    let tier: Tier
    let image: UIImage?
    let name: String
    var count: Int
    var isUnlocked: Bool
    
    init(rawValue: String, tier: Tier, image: UIImage?, name: String, count: Int = 1, isUnlocked: Bool = false) {
        self.rawValue = rawValue
        self.tier = tier
        self.image = image
        self.name = name
        self.count = count
        self.isUnlocked = isUnlocked
    }
    
    static func from(_ ingredient: Ingredient, count: Int = 1, isUnlocked: Bool = false) -> Card {
        Card(
            rawValue: ingredient.rawValue,
            tier: ingredient.tier,
            image: UIImage(named: ingredient.image),
            name: ingredient.name,
            count: count,
            isUnlocked: isUnlocked
        )
    }
    
    static func from(_ recipe: Recipe, count: Int = 1, isUnlocked: Bool = false) -> Card {
        Card(
            rawValue: recipe.rawValue,
            tier: recipe.tier,
            image: UIImage(named: recipe.image),
            name: recipe.name,
            count: count,
            isUnlocked: isUnlocked
        )
    }
}
