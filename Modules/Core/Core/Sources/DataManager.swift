//
//  DataManager.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import RCache

class DataManager {
    private static var _instance: DataManager?
    private static let lock = NSLock()
    
    var isFirstLaunch: Bool = false {
        didSet {
            RCache.common.save(bool: isFirstLaunch, key: .isFirstLaunch)
        }
    }
    
    var ingredients: [Ingredient] = []
    var unlockedIngredients: [Ingredient] = []
    var unlockedRecipes: [Recipe] = []
    
    private init(){}
    
    static var instance: DataManager {
        if _instance == nil {
            lock.lock()
            defer {
                lock.unlock()
            }
            if _instance == nil {
                _instance = DataManager()
            }
        }
        return _instance!
    }
    
    func initialize(completion: () -> Void) {
        isFirstLaunch = RCache.common.readBool(key: .isFirstLaunch) ?? false
        ingredients = (try? RCache.common.read(type: Array<Ingredient>.self, key: .ingredients)) ?? []
        unlockedIngredients = (try? RCache.common.read(type: Array<Ingredient>.self, key: .unlockedIngredients)) ?? []
        unlockedRecipes = (try? RCache.common.read(type: Array<Recipe>.self, key: .unlockedRecipes)) ?? []
        completion()
    }
    
    func gacha() -> [Ingredient] {
        let ingredientPool = Ingredient.allCases
        
        guard !ingredientPool.isEmpty else { return [] }
        
        func randomIngredient() -> Ingredient {
            let roll = Double.random(in: 0...1)
            var cumulativeRate = 0.0
            
            for tier in Tier.allCases.sorted(by: { $0.rate > $1.rate }) {
                cumulativeRate += tier.rate
                if roll < cumulativeRate {
                    let filteredIngredients = ingredientPool.filter { $0.tier == tier }
                    
                    if let ingredient = filteredIngredients.randomElement() {
                        return ingredient
                    }
                }
            }
            
            return ingredientPool.randomElement()!
        }
        
        let result = (0..<5).map { _ in randomIngredient() }
        
        ingredients.append(contentsOf: result)
        try? RCache.common.save(value: ingredients, key: .ingredients)
        
        for item in result {
            if !item.isUnlocked() {
                unlockedIngredients.append(item)
            }
        }
        try? RCache.common.save(value: unlockedIngredients, key: .unlockedIngredients)
        
        return result
    }
    
    func cook(from items: [Ingredient]) -> Recipe? {
        let result = Recipe.allCases
            .sorted { $0.tier.rate > $1.tier.rate }
            .first { recipe in recipe.ingredients.allSatisfy(items.contains) }
        
        if let result = result {
            if !result.isUnlocked() {
                unlockedRecipes.append(result)
            }
            
            try? RCache.common.save(value: unlockedRecipes, key: .unlockedRecipes)
        } else {
            for item in items {
                if let i = ingredients.firstIndex(of: item) {
                    ingredients.remove(at: i)
                }
            }
            
            try? RCache.common.save(value: ingredients, key: .ingredients)
        }
        
        return result
    }
}

extension Ingredient {
    func isUnlocked() -> Bool { DataManager.instance.unlockedIngredients.contains(where: { $0.rawValue == rawValue })}
}

extension Recipe {
    func isUnlocked() -> Bool { DataManager.instance.unlockedRecipes.contains(where: { $0.rawValue == rawValue })}
}
