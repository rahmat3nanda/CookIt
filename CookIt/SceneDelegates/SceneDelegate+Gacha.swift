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
        let presenter = GachaPresenter(view: controller)
        controller.presenter = presenter
        controller.delegate = self
        
        return controller
    }
}

extension SceneDelegate: GachaControllerDelegate {
    func didClose() {
        navigationController.topViewController?.dismiss(animated: true) { [weak self] in
            guard let c = self?.navigationController.topViewController as? HomeController else { return }
            c.updateData()
        }
    }
}
