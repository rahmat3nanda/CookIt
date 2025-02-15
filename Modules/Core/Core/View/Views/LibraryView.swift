//
//  LibraryView.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 16/02/25.
//

import UIKit
import Shared

protocol LibraryViewDelegate: AnyObject {
    func didSelect(_ item: Recipe)
    func didClose()
}

class LibraryView: UIView {
    
    weak var delegate: LibraryViewDelegate?
    
    private var selectedIndex: Int = 0 {
        didSet { update() }
    }
    
    private lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
            .rounded()
        
        return label
    }()
    
    private lazy var ingredientsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(named: "Accent")
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        view.addSubview(ingredientsLabel)
        ingredientsLabel.anchors.center.align()
        
        return view
    }()
    
    private lazy var recipesLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipes"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
            .rounded()
        
        return label
    }()
    
    private lazy var recipesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        view.addSubview(recipesLabel)
        recipesLabel.anchors.center.align()
        
        return view
    }()
    
    private lazy var menuView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [ingredientsView, recipesView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        ingredientsView.anchors.height.equal(view.anchors.height)
        ingredientsView.anchors.width.equal(128)
        recipesView.anchors.height.equal(view.anchors.height)
        recipesView.anchors.width.equal(128)
        
        return view
    }()
    
    private lazy var closeView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = .init(systemName: "xmark.circle")
        view.tintColor = .white
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        return collectionView
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

private extension LibraryView {
    private func configUI() {
        backgroundColor = .black.withAlphaComponent(0.7)
        addSubview(menuView)
        addSubview(closeView)
        addSubview(collectionView)
        
        menuView.anchors.size.equal(.init(width: 256, height: 48))
        menuView.anchors.centerX.equal(anchors.centerX)
        menuView.anchors.top.equal(anchors.top)
        
        closeView.anchors.size.equal(.init(width: 48, height: 48))
        closeView.anchors.trailing.equal(anchors.trailing, constant: -24)
        closeView.anchors.top.equal(anchors.top, constant: 24)
        
        collectionView.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading)
        collectionView.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing)
        collectionView.anchors.top.equal(menuView.anchors.bottom)
        collectionView.anchors.bottom.equal(anchors.bottom)
        
        configCollectionView()
        setupGestures()
    }
    
    private func setupGestures() {
        ingredientsView.onTap { [weak self] in
            self?.selectedIndex = 0
        }
        
        recipesView.onTap { [weak self] in
            self?.selectedIndex = 1
        }
        
        closeView.onTap { [weak self] in
            self?.delegate?.didClose()
        }
    }
    
    private func update() {
        ingredientsLabel.textColor = selectedIndex == 0 ? .white : .black
        ingredientsView.backgroundColor = selectedIndex == 0 ? .init(named: "Accent") : .white
        recipesLabel.textColor = selectedIndex == 1 ? .white : .black
        recipesView.backgroundColor = selectedIndex == 1 ? .init(named: "Accent") : .white
        collectionView.reloadData()
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCustomCell(CardItemCell.self)
    }
}


extension LibraryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedIndex == 0 ? Ingredient.allCases.count : Recipe.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: CardItemCell.self, indexPath: indexPath)
        if selectedIndex == 0 {
            let item = Ingredient.allCases.sortedByTierAndName()[indexPath.item]
            cell.setItem(.from(item, isUnlocked: item.isUnlocked()), showLockStatus: true)
        } else {
            let item = Recipe.allCases[indexPath.item]
            cell.setItem(.from(item, isUnlocked: item.isUnlocked()), showLockStatus: true)
            cell.onTap { [weak self] in
                self?.delegate?.didSelect(item)
            }
        }
        
        return cell
    }
}
extension LibraryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CardView.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    LibraryView()
//}
