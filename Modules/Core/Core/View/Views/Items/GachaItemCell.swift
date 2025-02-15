//
//  GachaItemCell.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import UIKit
import Shared

 class GachaItemCell: UICollectionViewCell {
    
    private lazy var cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
}

extension GachaItemCell {
    func setItem(_ item: Card) {
        cardView.item = item
    }
}

private extension GachaItemCell {
    private func configUI() {
        addSubview(cardView)
        cardView.anchors.edges.pin()
    }
}

@available(iOS 17.0, *)
#Preview {
    let card = GachaItemCell()
    card.setItem(.from(.bacon))
    
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(card)
    view.backgroundColor = .black
    
    card.anchors.center.align()
    card.anchors.size.equal(.init(width: 132, height: 176))
    
    return view
}
