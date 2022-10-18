//
//  BannerController.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

protocol BannerControllerDelegate: AnyObject {
    func bannerController(_ collectionView: UICollectionView, didSelectItemAtIndex: Int)
}

class BannerController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 100)
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identefier)
        collectionView.backgroundColor = .gray
        collectionView.frame.size = CGSize(width: view.frame.width, height: 120)
        collectionView.showsHorizontalScrollIndicator = false
        view = collectionView
        return collectionView
    }()
    var banners: [UIImage]!
    weak var delegate: BannerControllerDelegate?
    
    init(banners: [UIImage]) {
        super.init(nibName: nil, bundle: nil)
        self.banners = banners
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(collectionView)
    }
}

extension BannerController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bannerController(collectionView, didSelectItemAtIndex: indexPath.row)
    }
}

extension BannerController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identefier, for: indexPath) as? BannerCell {
            cell.fill(image: banners[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
