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
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    private var items: [Card] = []
    
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
    
    private lazy var ingredientsArrowView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "chevron.forward")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var ingredientsActionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white.withAlphaComponent(0.85)
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        view.addSubview(ingredientsArrowView)
        ingredientsArrowView.anchors.center.align()
        ingredientsArrowView.anchors.size.equal(.init(width: 24, height: 32))
        
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
    func setItems(_ items: [Card]) {
        self.items = items
        ingredientsEmptyLabel.isHidden = !self.items.isEmpty
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
        
        background.anchors.edges.pin()
        
        menuView.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -16)
        menuView.anchors.top.equal(safeAreaLayoutGuide.anchors.top, constant: 16)
        
        gachaView.anchors.size.equal(.init(width: 116, height: 116))
        gachaView.anchors.trailing.equal(anchors.trailing, constant: 16)
        gachaView.anchors.bottom.equal(anchors.bottom, constant: 16)
        
        ingredientsView.anchors.top.equal(anchors.top)
        ingredientsView.anchors.bottom.equal(anchors.bottom)
        ingredientsView.anchors.leading.equal(anchors.leading)
        
        configGestures()
        configCollectionView()
    }
    
    private func configGestures() {
        ingredientsActionView.onTap { [weak self] in
            
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
        ingredientsCollView.registerCustomCell(GachaItemCell.self)
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: GachaItemCell.self, indexPath: indexPath)
        cell.setItem(items[indexPath.item])
        return cell
    }
}
extension HomeView: UICollectionViewDelegateFlowLayout {
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
        0
    }
}


//@available(iOS 17.0, *)
//#Preview {
//    HomeView()
//}
