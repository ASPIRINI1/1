//
//  BannerCell.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.bounds)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        addSubview(imageView)
        return imageView
    }()
    
    func fill(image: UIImage) {
        imageView.image = image
    }
}
