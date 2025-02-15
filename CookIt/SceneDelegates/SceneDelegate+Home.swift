//
//  SceneDelegate+Home.swift
//  CookIt
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import UIKit
import Core

// MARK: - Home Page
extension SceneDelegate {
    func makeHomeController() -> UIViewController {
        let controller = HomeController()
        controller.delegate = self
        
        return controller
    }
}

extension SceneDelegate: HomeControllerDelegate {
    func navigateToGacha() {
        let target = makeGachaController()
        navigationController.present(target, animated: true)
    }
}
