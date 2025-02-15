//
//  HomePresenter.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import Foundation

public protocol HomePresenterProtocol: AnyObject {
    func didCook(from items: [Ingredient])
}

public class HomePresenter: HomePresenterProtocol {
    
    private weak var view: HomeControllerProtocol?
    
    public init(view: HomeControllerProtocol) {
        self.view = view
    }
    
    public func didCook(from items: [Ingredient]) {
        let result = DataManager.instance.cook(from: items)
        view?.didCookResult(result)
    }
}
