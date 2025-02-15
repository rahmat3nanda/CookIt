//
//  GachaController.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 14/02/25.
//

import UIKit


public protocol GachaControllerProtocol: AnyObject {
    func didGachaResult(_ results: [Ingredient])
}

public protocol GachaControllerDelegate: AnyObject {
    func didClose()
}

public class GachaController: UIViewController {
    private var tapCount: Int = 0
    
    public var presenter: GachaPresenterProtocol?
    public weak var delegate: GachaControllerDelegate?
    
    private lazy var mainView: GachaView = {
        let view = GachaView()
        view.delegate = self
        return view
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        super.loadView()
        view = mainView
    }
}

extension GachaController: GachaViewDelegate {
    func didTap() {
        guard tapCount < 4 else { return }
        
        if tapCount < 3 {
            mainView.animateChestBounce()
            SoundManager.instance.playSfx(type: .box)
        } else {
            mainView.animateChestOpen()
            SoundManager.instance.playSfx(type: .sparkle)
            presenter?.didGacha()
        }
        
        tapCount += 1
    }
    
    func didClose() {
        delegate?.didClose()
    }
}

extension GachaController: GachaControllerProtocol {
    public func didGachaResult(_ results: [Ingredient]) {
        func insertNext(index: Int) {
            guard index < results.count else { return }
            mainView.addItem(.from(results[index])) {
                DispatchQueue.main.async {
                    insertNext(index: index + 1)
                }
            }
        }
        
        insertNext(index: 0)
    }
}
