//
//  GachaPresenter.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import Foundation

public protocol GachaPresenterProtocol: AnyObject {
    func didGacha()
}

public class GachaPresenter: GachaPresenterProtocol {
    
    private weak var view: GachaControllerProtocol?
    
    public init(view: GachaControllerProtocol) {
        self.view = view
    }
    
    public func didGacha() {
        let result = DataManager.instance.gacha()
        view?.didGachaResult(result)
    }
}
