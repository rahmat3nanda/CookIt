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
        return result
    }
}
