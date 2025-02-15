//
//  Card.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import Foundation
import UIKit

class Card {
    let tier: Tier
    let image: UIImage?
    let name: String
    var count: Int
    
    init(tier: Tier, image: UIImage?, name: String) {
        self.tier = tier
        self.image = image
        self.name = name
        count = 1
    }
    
    static func from(_ ingredient: Ingredient) -> Card {
        return Card(tier: ingredient.tier, image: UIImage(named: ingredient.image), name: ingredient.name)
    }
    
    static func from(_ recipe: Recipe) -> Card {
        return Card(tier: recipe.tier, image: UIImage(named: recipe.icon), name: recipe.name)
    }
}
