//
//  SceneDelegate+Gacha.swift
//  CookIt
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import UIKit
import Core

// MARK: - Gacha Page
extension SceneDelegate {
    func makeGachaController() -> UIViewController {
        let controller = GachaController()
//        let presenter = SplashPresenter(view: controller)
//        controller.presenter = presenter
//        controller.delegate = self
        
        return controller
    }
}
