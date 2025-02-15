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
    func didLibrary()
    func didGacha()
    func didCook(from items: [Ingredient])
}

fileprivate enum CollTag: Int {
    case ingredients = 0
    case cook = 1
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    private var ingredientItems: [Card] = []
    private var cookItems: [Ingredient] = []
    private var isUpdating: Bool = false
    
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
        view.backgroundColor = .white.withAlphaComponent(0.75)
        view.layer.cornerRadius = 22
        
        view.addSubview(image)
        image.anchors.edges.pin(insets: 8)
        view.anchors.size.equal(.init(width: 44, height: 44))
        
        return view
    }()
    
    private lazy var libView: UIView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .init(named: "Library")
        image.contentMode = .scaleAspectFit
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.75)
        view.layer.cornerRadius = 22
        
        view.addSubview(image)
        image.anchors.edges.pin(insets: 8)
        view.anchors.size.equal(.init(width: 44, height: 44))
        
        return view
    }()
    
    private lazy var menuView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [libView, exitView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 12
        
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
    
    private lazy var ingredientsEmptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Empty Ingredients\nGacha to get it!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
            .rounded()
        
        return label
    }()
    
    private lazy var ingredientsCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.tag = CollTag.ingredients.rawValue
        collectionView.backgroundColor = .clear
        
        collectionView.addSubview(ingredientsEmptyLabel)
        ingredientsEmptyLabel.anchors.center.align()
        
        return collectionView
    }()
    
    private lazy var ingredientsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(named: "Accent")?.withAlphaComponent(0.75)
        view.layer.cornerRadius = 16
        
        view.addSubview(ingredientsCollView)
        ingredientsCollView.anchors.top.equal(view.anchors.top)
        ingredientsCollView.anchors.bottom.equal(view.anchors.bottom)
        ingredientsCollView.anchors.leading.equal(view.safeAreaLayoutGuide.anchors.leading)
        ingredientsCollView.anchors.width.equal(CardView.size.width + 32)
        
        return view
    }()
    
    
    private lazy var cookCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.tag = CollTag.cook.rawValue
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private lazy var cookView: UIView = {
        let label = UILabel()
        label.text = "CookIt!"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
            .rounded()
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(named: "Accent")?.withAlphaComponent(0.85)
        view.layer.cornerRadius = 16
        view.isHidden = true
        
        view.addSubview(label)
        label.anchors.center.align()
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ingredientsView.anchors.width.equal(CardView.size.width + 32 + safeAreaInsets.left)
    }
}

extension HomeView {
    func setIngredients(_ items: [Card]) {
        ingredientItems = items
        ingredientsEmptyLabel.isHidden = !self.ingredientItems.isEmpty
        ingredientsCollView.reloadData()
    }
}

private extension HomeView {
    private func configUI() {
        backgroundColor = .black
        addSubview(background)
        addSubview(menuView)
        addSubview(gachaView)
        addSubview(ingredientsView)
        addSubview(cookCollView)
        addSubview(cookView)
        
        background.anchors.edges.pin()
        
        menuView.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -16)
        menuView.anchors.top.equal(safeAreaLayoutGuide.anchors.top, constant: 16)
        
        gachaView.anchors.size.equal(.init(width: 116, height: 116))
        gachaView.anchors.trailing.equal(anchors.trailing, constant: 16)
        gachaView.anchors.bottom.equal(anchors.bottom, constant: 16)
        
        ingredientsView.anchors.top.equal(anchors.top)
        ingredientsView.anchors.bottom.equal(anchors.bottom)
        ingredientsView.anchors.leading.equal(anchors.leading)
        
        cookCollView.anchors.leading.equal(ingredientsView.anchors.trailing)
        cookCollView.anchors.trailing.equal(anchors.trailing)
        cookCollView.anchors.centerY.equal(anchors.centerY)
        cookCollView.anchors.height.equal(CardView.size.height)
        
        cookView.anchors.size.equal(.init(width: 128, height: 48))
        cookView.anchors.centerX.equal(anchors.centerX)
        cookView.anchors.bottom.equal(safeAreaLayoutGuide.anchors.bottom, constant: -16)
        
        configGestures()
        configCollectionView()
    }
    
    private func configGestures() {
        cookView.onTap { [weak self] in
            guard let self = self else { return }
            self.delegate?.didCook(from: self.cookItems)
        }
        
        exitView.onTap { [weak self] in
            self?.delegate?.didExit()
        }
        
        libView.onTap { [weak self] in
            self?.delegate?.didLibrary()
        }
        
        gachaView.onTap { [weak self] in
            self?.delegate?.didGacha()
        }
    }
    
    private func configCollectionView() {
        ingredientsCollView.dataSource = self
        ingredientsCollView.delegate = self
        ingredientsCollView.registerCustomCell(CardItemCell.self)
        cookCollView.dataSource = self
        cookCollView.delegate = self
        cookCollView.registerCustomCell(CardItemCell.self)
    }
    
    private func didIngredientItemTap(_ item: Card) {
        guard !isUpdating, !cookItems.contains(where: { $0.rawValue == item.rawValue }) else { return }
        
        isUpdating = true
        cookItems.append(Ingredient(rawValue: item.rawValue)!)
        cookView.isHidden = false
        
        update(
            collectionView: cookCollView,
            at: cookItems.count - 1,
            isInsert: true,
            position: .right
        ) { [weak self] in
            guard let self = self else { return }
            
            guard let ingredientIndex = self.ingredientItems.firstIndex(where: { $0.rawValue == item.rawValue }) else {
                self.isUpdating = false
                return
            }
            
            self.ingredientItems[ingredientIndex].count -= 1
            
            if self.ingredientItems[ingredientIndex].count < 1 {
                self.ingredientItems.remove(at: ingredientIndex)
                self.update(
                    collectionView: self.ingredientsCollView,
                    at: ingredientIndex,
                    isInsert: false,
                    position: .bottom
                ) { [weak self] in
                    guard let self = self else { return }
                    self.ingredientsEmptyLabel.isHidden = !self.ingredientItems.isEmpty
                    self.isUpdating = false
                }
            } else {
                let updatedIndexPath = IndexPath(item: ingredientIndex, section: 0)
                self.ingredientsCollView.reloadItems(at: [updatedIndexPath])
                self.isUpdating = false
            }
        }
    }
    
    private func didCookItemTap(_ item: Card) {
        guard !isUpdating, let cookIndex = cookItems.firstIndex(where: { $0.rawValue == item.rawValue }) else { return }
        
        isUpdating = true
        cookItems.remove(at: cookIndex)
        cookView.isHidden = cookItems.isEmpty

        update(
            collectionView: cookCollView,
            at: cookIndex,
            isInsert: false,
            position: .left
        ) { [weak self] in
            guard let self = self else { return }

            if let ingredientIndex = self.ingredientItems.firstIndex(where: { $0.rawValue == item.rawValue }) {
                self.ingredientItems[ingredientIndex].count += 1
                
                let updatedIndexPath = IndexPath(item: ingredientIndex, section: 0)
                self.ingredientsCollView.reloadItems(at: [updatedIndexPath])
                self.isUpdating = false
            } else {
                let newIngredient = Ingredient(rawValue: item.rawValue)!
                self.ingredientItems.append(.from(newIngredient))

                self.update(
                    collectionView: self.ingredientsCollView,
                    at: self.ingredientItems.count - 1,
                    isInsert: true,
                    position: .bottom
                ) { [weak self] in
                    guard let self = self else { return }

                    self.ingredientsEmptyLabel.isHidden = !self.ingredientItems.isEmpty
                    self.isUpdating = false
                }
            }
        }
    }
    
    private func update(
        collectionView: UICollectionView,
        at index: Int,
        isInsert: Bool,
        position: UICollectionView.ScrollPosition,
        completion: (() -> Void)? = nil
    ) {
        guard index >= 0, index <= collectionView.numberOfItems(inSection: 0) else {
            completion?()
            return
        }

        let path = IndexPath(item: index, section: 0)
        DispatchQueue.main.async {
            collectionView.performBatchUpdates({
                if isInsert {
                    collectionView.insertItems(at: [path])
                } else {
                    collectionView.deleteItems(at: [path])
                }
            }, completion: { _ in
                if isInsert {
                    collectionView.scrollToItem(at: path, at: position, animated: true)
                }
                completion?()
            })
        }
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.tag.collTag == .ingredients ? ingredientItems.count : cookItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isIngredient = collectionView.tag.collTag == .ingredients
        let item = isIngredient ? ingredientItems[indexPath.item] : .from(cookItems[indexPath.item])
        let cell = collectionView.dequeueReusableCustomCell(with: CardItemCell.self, indexPath: indexPath)
        cell.setItem(item)
        cell.showCount = collectionView.tag.collTag == .ingredients
        cell.onTap { [weak self] in
            guard let self = self else { return }
            isIngredient ? self.didIngredientItemTap(item) : self.didCookItemTap(item)
        }
        return cell
    }
}
extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(
            top: collectionView.tag.collTag == .ingredients ? 16 : 0,
            left: 16,
            bottom: collectionView.tag.collTag == .ingredients ? 16 : 0,
            right: 16
        )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CardView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

fileprivate extension Int {
    var collTag: CollTag? {
        if self == CollTag.ingredients.rawValue {
            return .ingredients
        }
        if self == CollTag.ingredients.rawValue {
            return .cook
        }
        return nil
    }
}


//@available(iOS 17.0, *)
//#Preview {
//    HomeView()
//}
