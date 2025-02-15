//
//  CookView.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import UIKit
import Lottie
import Shared

protocol CookViewDelegate: AnyObject {
    func didClose()
}

class CookView: UIView {
    
    weak var delegate: CookViewDelegate?
    var item: Recipe?
    
    private lazy var wokView: LottieAnimationView = {
        let view = LottieAnimationView(name: "WokAnim")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .playOnce
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var burnView: LottieAnimationView = {
        let view = LottieAnimationView(name: "FireAnim")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .playOnce
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        
        return view
    }()
    
    private lazy var cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        view.anchors.size.equal(CardView.size)
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animateWok()
    }
}

private extension CookView {
    private func configUI() {
        backgroundColor = .black.withAlphaComponent(0.7)
        addSubview(wokView)
        addSubview(burnView)
        addSubview(cardView)
        addSubview(closeView)
        
        wokView.anchors.width.equal(safeAreaLayoutGuide.anchors.height, constant: -16)
        wokView.anchors.height.equal(safeAreaLayoutGuide.anchors.height, constant: -16)
        wokView.anchors.center.align()
        
        burnView.anchors.width.equal(safeAreaLayoutGuide.anchors.height, constant: -16)
        burnView.anchors.height.equal(safeAreaLayoutGuide.anchors.height, constant: -16)
        burnView.anchors.center.align()
        
        cardView.anchors.center.align()
        
        closeView.anchors.size.equal(.init(width: 48, height: 48))
        closeView.anchors.trailing.equal(anchors.trailing, constant: -24)
        closeView.anchors.top.equal(anchors.top, constant: 24)
        
        closeView.onTap { [weak self] in
            guard let self = self else { return }
            SoundManager.instance.stopSfx()
            self.burnView.stop()
            self.delegate?.didClose()
        }
    }
    
    private func animateWok() {
        SoundManager.instance.playSfx(type: .sizzle)
        wokView.play { [weak self] _ in
            guard let self = self else { return }
            
            self.wokView.isHidden = true
            if let recipe = self.item {
                self.animateCard(.from(recipe))
            } else {
                self.animateBurn()
            }
        }
    }
    
    private func animateCard(_ item: Card) {
        cardView.item = item
        cardView.isHidden = false

        SoundManager.instance.playSfx(type: .sparkle)
        UIView.animate(
            withDuration: 2,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut
        ) {
            self.cardView.transform = .identity
        } completion: { _ in
            self.closeView.isHidden = false
        }
    }
    
    private func animateBurn() {
        SoundManager.instance.playSfx(type: .burn)
        burnView.isHidden = false
        burnView.play { [weak self] _ in
            self?.animateBurn()
        }
        closeView.isHidden = false
    }
}
