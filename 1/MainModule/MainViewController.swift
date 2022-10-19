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
    private lazy var productsController: ProductsController = {
        let products = ProductsController()
        products.view.translatesAutoresizingMaskIntoConstraints = false
        products.delegate = self
        addChild(products)
        products.didMove(toParent: self)
        return products
    }()
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        presenter.viewLoaded()
        view.addSubview(bannerController.view)
        view.addSubview(categoriesController.view)
        view.addSubview(productsController.view)
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        bannerController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bannerController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bannerController.view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        categoriesController.view.topAnchor.constraint(equalTo: bannerController.view.bottomAnchor).isActive = true
        categoriesController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        categoriesController.view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        productsController.view.topAnchor.constraint(equalTo: categoriesController.view.bottomAnchor).isActive = true
        productsController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        productsController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}

//  MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    func scrollTo() {
        productsController.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func reloadProducts() {
        productsController.reloadData(products: presenter.products)
    }
}

//  MARK: - BannerControllerDelegate

extension MainViewController: BannerControllerDelegate {
    func bannerController(_ collectionView: UICollectionView, didSelectItemAt index: Int) {
        presenter.bannerSelected(index: index)
    }
}

//  MARK: - CategoriesControllerDelegate

extension MainViewController: CategoriesControllerDelegate {
    func categoriesController(_ viewController: CategoriesController, didSelectItemAt index: Int) {
        presenter.categorySelected(index: index)
    }
}

extension MainViewController: ProductsControllerDelegate {
    func productsController(_ tableViewController: UITableViewController, didSelectProducAt index: Int) {
        presenter.productSelected(index: index)
    }
    
    func productsController(_ tableViewController: UITableViewController, didTapProductBuyButtonAt index: Int) {
        presenter.productBuyButtonTapped(index: index)
    }
}
