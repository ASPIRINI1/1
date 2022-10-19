//
//  BannerController.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

protocol BannerControllerDelegate: AnyObject {
    func bannerController(_ collectionController: UICollectionView, didSelectItemAt index: Int)
}

class BannerController: UICollectionViewController {
    
    var banners: [UIImage]
    weak var delegate: BannerControllerDelegate?
    
    init(banners: [UIImage]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 120)
        self.banners = banners
        super.init(collectionViewLayout: layout)
        view = collectionView
        collectionView.frame.size = CGSize(width: view.frame.width, height: 120)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identefier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension BannerController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identefier, for: indexPath) as? BannerCell {
            cell.fill(image: banners[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension BannerController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bannerController(collectionView, didSelectItemAt: indexPath.row)
    }
}
