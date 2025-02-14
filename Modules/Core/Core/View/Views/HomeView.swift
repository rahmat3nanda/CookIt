//
//  HomeView.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 14/02/25.
//

import UIKit
import Shared

protocol HomeViewDelegate: AnyObject {
    func didExit()
    func didGacha()
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    var isExpanded: Bool = true
    
    private lazy var background: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Background")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var exitView: UIView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .init(named: "Exit")
        image.contentMode = .scaleAspectFit
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 22
        
        view.addSubview(image)
        image.anchors.edges.pin(insets: 8)
        
        return view
    }()
    
    private lazy var gachaView: UIView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .init(named: "Chest")
        image.contentMode = .scaleAspectFit
        image.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(named: "Accent")?.withAlphaComponent(0.85)
        view.layer.cornerRadius = 58
        
        view.addSubview(image)
        image.anchors.size.equal(.init(width: 82, height: 82))
        image.anchors.leading.equal(view.anchors.leading, constant: 12)
        image.anchors.top.equal(view.anchors.top, constant: 12)
        
        return view
    }()
    
    private lazy var ingredientsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.85)
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
}

private extension HomeView {
    private func configUI() {
        backgroundColor = .black
        addSubview(background)
        addSubview(exitView)
        addSubview(gachaView)
        addSubview(ingredientsView)
        
        background.anchors.edges.pin()
        
        exitView.anchors.size.equal(.init(width: 44, height: 44))
        exitView.anchors.trailing.equal(anchors.trailing, constant: -32)
        exitView.anchors.top.equal(anchors.top, constant: 16)
        exitView.onTap { [weak self] in
            self?.delegate?.didExit()
        }
        
        gachaView.anchors.size.equal(.init(width: 116, height: 116))
        gachaView.anchors.trailing.equal(anchors.trailing, constant: 16)
        gachaView.anchors.bottom.equal(anchors.bottom, constant: 16)
        gachaView.onTap { [weak self] in
            self?.delegate?.didGacha()
        }
        
        ingredientsView.anchors.top.equal(anchors.top)
        ingredientsView.anchors.bottom.equal(anchors.bottom)
        ingredientsView.anchors.width.equal(200)
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    HomeView()
//}
