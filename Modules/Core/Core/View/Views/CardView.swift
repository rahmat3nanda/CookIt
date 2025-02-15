//
//  CardView.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 15/02/25.
//

import UIKit
import Shared

class CardView: UIView {
    
    static var size: CGSize = .init(width: 132, height: 176)
    
    var item: Card? {
        didSet {
            updateView()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var nameLabel = {
        let label = UILabel()
        label.text = "Item"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .semibold)
            .rounded()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private lazy var tierLabel = {
        let label = UILabel()
        label.text = "Tier"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
            .rounded()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        view.addSubview(imageView)
        imageView.anchors.height.equal(view.anchors.width, constant: -8)
        imageView.anchors.top.equal(view.anchors.top, constant: 4)
        imageView.anchors.leading.equal(view.anchors.leading, constant: 4)
        imageView.anchors.trailing.equal(view.anchors.trailing, constant: -4)
        
        let container = UIStackView(arrangedSubviews: [nameLabel, tierLabel])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 2
        
        view.addSubview(container)
        container.anchors.bottom.equal(view.anchors.bottom, constant: -4)
        container.anchors.leading.equal(view.anchors.leading, constant: 4)
        container.anchors.trailing.equal(view.anchors.trailing, constant: -4)
        
        
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

private extension CardView {
    private func configUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
        addSubview(contentView)
        
        contentView.anchors.edges.pin(insets: 8)
    }
    
    private func updateView() {
        contentView.backgroundColor = item?.tier.color
        imageView.image = item?.image
        nameLabel.text = item?.name
        tierLabel.text = item?.tier.name
    }
}

@available(iOS 17.0, *)
#Preview {
    let card = CardView()
    card.item = .from(.bacon)
    
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(card)
    view.backgroundColor = .black
    
    card.anchors.center.align()
    card.anchors.size.equal(CardView.size)
    
    return view
}
