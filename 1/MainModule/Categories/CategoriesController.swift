//
//  CategoriesController.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

protocol CategoriesControllerDelegate: AnyObject {
    func categoriesController(_ collectionController: CategoriesController, didSelectItemAt index: Int)
}

class CategoriesController: UICollectionViewController {
    
    var categories: [String]
    weak var delegate: CategoriesControllerDelegate?
    
    init(categories: [String]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 31)
        self.categories = categories
        super.init(collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
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
        delegate?.categoriesController(self, didSelectItemAt: indexPath.row)
    }
}
