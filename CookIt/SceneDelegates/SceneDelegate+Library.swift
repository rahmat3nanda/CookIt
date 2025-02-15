//
//  SceneDelegate+Library.swift
//  CookIt
//
//  Created by Rahmat Trinanda Pramudya Amar on 16/02/25.
//

import UIKit
import Core

// MARK: - Library Page
extension SceneDelegate {
    func makeLibraryController() -> UIViewController {
        let controller = LibraryController()
        controller.delegate = self
        
        return controller
    }
}

extension SceneDelegate: LibraryControllerDelegate {
    func libraryDidSelect(_ item: Recipe) {
        navigationController.topViewController?.dismiss(animated: true) { [weak self] in
            guard let c = self?.navigationController.topViewController as? HomeController else { return }
            c.makeRecipe(item)
        }
    }
    
    func libraryDidClose() {
        navigationController.topViewController?.dismiss(animated: true)
    }
}
