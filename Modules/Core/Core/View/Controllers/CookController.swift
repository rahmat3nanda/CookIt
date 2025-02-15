//
//  CookController.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import UIKit

public protocol CookControllerDelegate: AnyObject {
    func cookDidClose()
}

public class CookController: UIViewController {
    
    public weak var delegate: CookControllerDelegate?
    public var item: Recipe?
    
    
    private lazy var mainView: CookView = {
        let view = CookView()
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
        mainView.item = item
    }
}

extension CookController: CookViewDelegate {
    func didClose() {
        delegate?.cookDidClose()
    }
}
