//
//  RCache+Key.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 14/02/25.
//

import RCache

extension RCache.Key {
   static let isFirstLaunch = RCache.Key("isFirstLaunch")
   static let ingredients = RCache.Key("ingredients")
   static let unlockedIngredients = RCache.Key("unlockedIngredients")
   static let unlockedRecipes = RCache.Key("unlockedRecipes")
}
