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
        banners.view.translatesAutoresizingMaskIntoConstraints = false
        banners.delegate = self
        addChild(banners)
        banners.didMove(toParent: self)
        return banners
    }()
    private lazy var categoriesController: UIViewController = {
        let categories = CategoriesController(categories: presenter.categories)
        categories.view.translatesAutoresizingMaskIntoConstraints = false
        categories.delegate = self
        addChild(categories)
        categories.didMove(toParent: self)
        return categories
    }()
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerController.view)
        view.addSubview(categoriesController.view)
    }

}

//  MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    func scrollTo() {
        
    }
}

//  MARK: - BannerControllerDelegate

extension MainViewController: BannerControllerDelegate {
    func bannerController(_ collectionView: UICollectionView, didSelectItemAtIndex: Int) {
        presenter.bannerSelected()
    }
}

//  MARK: - CategoriesControllerDelegate

extension MainViewController: CategoriesControllerDelegate {
    func categoriesController(_ viewController: CategoriesController, didSelectItemAtIndex: Int) {
        presenter.categorySelected()
    }
}
