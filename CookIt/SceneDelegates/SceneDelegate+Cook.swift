//
//  SceneDelegate+Cook.swift
//  CookIt
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import UIKit
import Core

// MARK: - Cook Page
extension SceneDelegate {
    func makeCookController(item: Recipe?) -> UIViewController {
        let controller = CookController()
        controller.delegate = self
        controller.item = item
        
        return controller
    }
}

extension SceneDelegate: CookControllerDelegate {
    func cookDidClose() {
        navigationController.topViewController?.dismiss(animated: true)
    }
}
