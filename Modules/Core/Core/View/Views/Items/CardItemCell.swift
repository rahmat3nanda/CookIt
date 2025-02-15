//
//  GachaItemCell.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import UIKit
import Shared

class CardItemCell: UICollectionViewCell {
    
    private var item: Card? = nil
    
    var showCount: Bool = false {
        didSet { update() }
    }
    
    private lazy var cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
            .rounded()
        return label
    }()
    
    private lazy var countView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 16
        view.isHidden = true
        
        view.addSubview(countLabel)
        countLabel.anchors.edges.pin(insets: 4)
        
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

extension CardItemCell {
    func setItem(_ item: Card, showLockStatus: Bool = false) {
        self.item = item
        cardView.item = item
        cardView.showLockStatus = showLockStatus
        countView.isHidden = !showCount || item.count < 1
        countLabel.text = "\(item.count)"
    }
}

private extension CardItemCell {
    private func configUI() {
        addSubview(cardView)
        addSubview(countView)
        
        cardView.anchors.edges.pin()
        countView.anchors.top.equal(anchors.top)
        countView.anchors.trailing.equal(anchors.trailing)
        countView.anchors.size.equal(.init(width: 32, height: 32))
    }
    
    private func update() {
        cardView.anchors.edges.pin(insets: showCount ? 12 : 0)
        countView.isHidden = !showCount || (item?.count ?? 0) < 1
    }
}

@available(iOS 17.0, *)
#Preview {
    let card = CardItemCell()
    card.setItem(.from(.bacon))
    card.showCount = true
    
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(card)
    view.backgroundColor = .black
    
    card.anchors.center.align()
    card.anchors.size.equal(.init(width: 132, height: 176))
    
    return view
}
