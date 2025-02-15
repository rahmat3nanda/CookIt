//
//  SplashPresenter.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation

public protocol SplashPresenterProtocol: AnyObject {
    func loadData()
    func loadSound()
}

public class SplashPresenter: SplashPresenterProtocol {
    private weak var view: SplashControllerProtocol?
    
    public init(view: SplashControllerProtocol) {
        self.view = view
    }
    
    public func loadData() {
        DataManager.instance.initialize { [weak self] in
            self?.view?.dataLoaded()
        }
    }
    public func loadSound() {
        SoundManager.instance.initialize { [weak self] in
            self?.view?.soundLoaded()
        }
    }
}
