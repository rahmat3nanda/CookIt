//
//  SplashPresenter.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation

public protocol SplashPresenterProtocol: AnyObject {
    func loadData()
}

public class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashControllerProtocol?
    
    
    public init(view: SplashControllerProtocol) {
        self.view = view
    }
    
    public func loadData() {
        DataManager.instance.initialize { [weak self] in
            self?.view?.loadCompleted()
        }
    }
}
