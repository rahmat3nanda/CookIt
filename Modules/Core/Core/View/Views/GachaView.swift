//
//  GachaView.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 14/02/25.
//

import UIKit
import Shared
import Lottie

protocol GachaViewDelegate: AnyObject {
    func didTap()
    func didClose()
}

class GachaView: UIView {
    
    weak var delegate: GachaViewDelegate?
    
    private lazy var chestView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = .init(named: "Chest")
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var chestAnimView: LottieAnimationView = {
        let view = LottieAnimationView(name: "ChestAnim")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .playOnce
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()
    
    private lazy var splashAnimView: LottieAnimationView = {
        let view = LottieAnimationView(name: "SplashAnim")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .playOnce
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()
    
    private lazy var closeView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = .init(systemName: "xmark.circle")
        view.tintColor = .white
        view.isHidden = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
}

private extension GachaView {
    private func configUI() {
        backgroundColor = .black.withAlphaComponent(0.7)
        addSubview(chestView)
        addSubview(chestAnimView)
        addSubview(splashAnimView)
        addSubview(closeView)
        
        chestView.anchors.size.equal(.init(width: 128, height: 128))
        chestView.anchors.center.align()
        
        chestAnimView.anchors.size.equal(.init(width: 216, height: 216))
        chestAnimView.anchors.center.align()
        splashAnimView.anchors.edges.pin()
        
        closeView.anchors.size.equal(.init(width: 48, height: 48))
        closeView.anchors.trailing.equal(anchors.trailing, constant: -24)
        closeView.anchors.top.equal(anchors.top, constant: 24)
        
        onTap { [weak self] in
            self?.delegate?.didTap()
        }
        
        closeView.onTap { [weak self] in
            self?.delegate?.didClose()
        }
    }
}

extension GachaView {
    func animateChestBounce() {
        chestView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut
        ) {
            self.chestView.transform = .identity
        }
    }
    
    func animateChestOpen() {
        chestView.isHidden = true
        
        chestAnimView.isHidden = false
        chestAnimView.play { [weak self] completed in
            guard let self = self else { return }
            
            self.splashAnimView.isHidden = false
            self.splashAnimView.play { [weak self] completed in
                guard let self = self else { return }
                self.closeView.isHidden = false
            }
        }
        
    }
}
