//
//  LibraryController.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 16/02/25.
//

import UIKit

public protocol LibraryControllerDelegate: AnyObject {
    func libraryDidClose()
    func libraryDidSelect(_ item: Recipe)
}

public class LibraryController: UIViewController {
    
    public weak var delegate: LibraryControllerDelegate?
    
    private lazy var mainView: LibraryView = {
        let view = LibraryView()
        view.delegate = self
        return view
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        super.loadView()
        view = mainView
    }
}

extension LibraryController: LibraryViewDelegate {
    func didSelect(_ item: Recipe) {
        if item.isUnlocked() {
            delegate?.libraryDidSelect(item)
        } else {
            didClose()
        }
    }
    
    func didClose() {
        delegate?.libraryDidClose()
    }
}
