//
//  HomeController.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 14/02/25.
//

import UIKit
import Shared

public protocol HomeControllerProtocol: AnyObject {
    func didCookResult(_ result: Recipe?)
}

public protocol HomeControllerDelegate: AnyObject {
    func navigateToGacha()
    func navigateToCook(result recipe: Recipe?)
}

public class HomeController: UIViewController {
    
    public var presenter: HomePresenterProtocol?
    public weak var delegate: HomeControllerDelegate?
    
    private lazy var mainView: HomeView = {
        let view = HomeView()
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
        updateData()
    }
}

public extension HomeController {
    func updateData() {
        mainView.setIngredients(DataManager.instance.ingredients.toCard())
        mainView.clearCooks()
    }
}

extension HomeController: HomeViewDelegate {
    func didExit() {
        let actionSheet = UIAlertController(title: "Exit Game", message: "Are you sure want to exit?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Exit", style: .destructive, handler: { [weak self] _ in
            guard self != nil else { return }
            exit(0)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func didLibrary() {
        
    }
    
    func didGacha() {
        delegate?.navigateToGacha()
    }
    
    func didCook(from items: [Ingredient]) {
        presenter?.didCook(from: items)
    }
}

extension HomeController: HomeControllerProtocol {
    public func didCookResult(_ result: Recipe?) {
        delegate?.navigateToCook(result: result)
    }
}
