//
//  CategoriesCell.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemRed.cgColor
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        addSubview(label)
        return label
    }()
    
    func fill(title: String) {
        label.text = title
    }
    
    func set(selected: Bool) {
        if selected {
            label.backgroundColor = .systemRed.withAlphaComponent(0.3)
        } else {
            label.backgroundColor = .clear
        }
    }
}
