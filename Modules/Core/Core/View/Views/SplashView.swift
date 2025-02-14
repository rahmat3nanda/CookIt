//
//  SplashView.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import UIKit
import Shared

protocol SplashViewDelegate: AnyObject {
    func animationCompleted()
}

public class SplashView: UIView {
    weak var delegate: SplashViewDelegate?

    private lazy var label = {
        let label = UILabel()
        label.text = "CookIt!"
        label.textColor = .white
        label.font = .systemFont(ofSize: 64, weight: .bold)
            .rounded()
        return label
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

private extension SplashView {
    private func configUI() {
        backgroundColor = .black
        addSubview(label)

        label.anchors.center.align()
        label.transform = CGAffineTransform(scaleX: 0, y: 0)
        label.alpha = 0
    }
}

extension SplashView {
    func animateLabel() {
        UIView.animate(
            withDuration: 2,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0,
            options: .curveEaseOut
        ) {
            self.label.transform = .identity
            self.label.alpha = 1
        } completion: { bool in
            self.delegate?.animationCompleted()
        }
    }
}
//
//@available(iOS 17.0, *)
//#Preview {
//    SplashView()
//}
