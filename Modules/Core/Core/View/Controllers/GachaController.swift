//
//  GachaController.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 14/02/25.
//

import UIKit

public class GachaController: UIViewController {
    private var tapCount: Int = 0
    
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
        } else {
            mainView.animateChestOpen()
        }
        
        tapCount += 1
    }
    
    func didClose() {
        dismiss(animated: true)
    }
}
