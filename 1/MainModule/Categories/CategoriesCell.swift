//
//  CategoriesCell.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = self.bounds
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.setTitleColor(.systemRed, for: .normal)
        addSubview(button)
        return button
    }()
    
    func fill(title: String) {
        button.setTitle(title, for: .normal)
    }
}
