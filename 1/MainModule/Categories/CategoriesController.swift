//
//  CategoriesController.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

protocol CategoriesControllerDelegate: AnyObject {
    func categoriesController(_ viewController: CategoriesController, didSelectItemAtIndex: Int)
}

class CategoriesController: UICollectionViewController {
    
    var categories: [String]!
    weak var delegate: CategoriesControllerDelegate?
    
    init(categories: [String]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 31)
        super.init(collectionViewLayout: layout)
        self.categories = categories
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identefier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension CategoriesController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identefier, for: indexPath) as? CategoriesCell {
            cell.fill(title: categories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension CategoriesController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.categoriesController(self, didSelectItemAtIndex: indexPath.row)
    }
}
