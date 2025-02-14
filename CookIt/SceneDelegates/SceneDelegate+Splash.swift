//
//  SceneDelegate+Splash.swift
//  CookIt
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import UIKit
import Core

// MARK: - Splash Page
extension SceneDelegate {
    func makeSplashController() -> UIViewController {
        let controller = SplashController()
        let presenter = SplashPresenter(view: controller)
        controller.presenter = presenter
        controller.delegate = self
        
        return controller
    }
}

extension SceneDelegate: SplashControllerDelegate {
    func navigateToHome() {
        let target = makeHomeController()
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(target, animated: true)
    }
}
