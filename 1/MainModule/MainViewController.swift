//
//  MainViewController.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var bannerController: UIViewController = {
        let banners = BannerController(banners: presenter.banners)
        banners.delegate = self
        addChild(banners)
        banners.didMove(toParent: self)
        return banners
    }()
    
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bannerController.view)
    }
}

extension MainViewController: BannerControllerDelegate {
    func bannerController(_ collectionView: UICollectionView, didSelectItemAtIndex: Int) {
        presenter.bannerSelected()
    }
}

extension MainViewController: MainViewProtocol {
    func scrollTo() {
        
    }
}
