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
//        banners.view.translatesAutoresizingMaskIntoConstraints = false
        banners.delegate = self
        addChild(banners)
        banners.didMove(toParent: self)
        return banners
    }()
    private lazy var categoriesController: UIViewController = {
        let categories = CategoriesController(categories: presenter.categories)
//        categories.view.translatesAutoresizingMaskIntoConstraints = false
        categories.delegate = self
        addChild(categories)
        categories.didMove(toParent: self)
        return categories
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UINib(nibName: TableViewCell.identefier, bundle: nil), forCellReuseIdentifier: TableViewCell.identefier)
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 15
        return tableView
    }()
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
//        view.addSubview(bannerController.view)
//        view.addSubview(categoriesController.view)
//        view.addSubview(tableView)
    }
}

//  MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    func scrollTo() {
        
    }
}

//  MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identefier, for: indexPath) as? TableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}

//  MARK: - TableViewCellDelegate

extension MainViewController: TableViewCellDelegate {
    func tableViewCell(_ cell: UITableViewCell, didSelectProductForID productID: String) {
        presenter.productSelected()
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
