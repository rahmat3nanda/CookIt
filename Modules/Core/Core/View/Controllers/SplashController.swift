//
//  SplashController.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import UIKit

public protocol SplashControllerProtocol: AnyObject {
    func loadCompleted()
}

public protocol SplashControllerDelegate: AnyObject {
    func navigateToHome()
}

public class SplashController: UIViewController {
    public var presenter: SplashPresenterProtocol?
    public weak var delegate: SplashControllerDelegate?
    
    private lazy var mainView: SplashView = {
        let view = SplashView()
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        mainView.animateLabel()
    }
}

extension SplashController: SplashControllerProtocol {
    public func loadCompleted() {
        delegate?.navigateToHome()
    }
}

extension SplashController: SplashViewDelegate {
    func animationCompleted() {
        presenter?.loadData()
    }
}
