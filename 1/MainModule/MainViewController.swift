//
//  MainViewController.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var bannerController: BannerController = {
        let banners = BannerController(banners: presenter.banners)
        banners.view.translatesAutoresizingMaskIntoConstraints = false
        banners.delegate = self
        addChild(banners)
        banners.didMove(toParent: self)
        return banners
    }()
    private lazy var categoriesController: CategoriesController = {
        let categories = CategoriesController(categories: presenter.categories)
        categories.view.translatesAutoresizingMaskIntoConstraints = false
        categories.delegate = self
        addChild(categories)
        categories.didMove(toParent: self)
        return categories
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 15
        tableView.register(UINib(nibName: TableViewCell.identefier, bundle: nil), forCellReuseIdentifier: TableViewCell.identefier)
        return tableView
    }()
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        view.addSubview(bannerController.view)
        view.addSubview(categoriesController.view)
        view.addSubview(tableView)
        view.backgroundColor = .systemGray5
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let bannersHeight = 120.0
        let categoriesHeight = 60.0
        
        bannerController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bannerController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bannerController.view.heightAnchor.constraint(equalToConstant: bannersHeight).isActive = true
        
        categoriesController.view.topAnchor.constraint(equalTo: bannerController.view.bottomAnchor).isActive = true
        categoriesController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        categoriesController.view.heightAnchor.constraint(equalToConstant: categoriesHeight).isActive = true

        tableView.topAnchor.constraint(equalTo: categoriesController.view.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -(categoriesHeight + view.safeAreaLayoutGuide.layoutFrame.minY)).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}

//  MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    func scrollTo(section: Int) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
    }
    
    func reloadProducts() {
        tableView.reloadData()
        categoriesController.update(categories: presenter.categories)
    }
}

//  MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.products[section].category
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.products[section].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identefier, for: indexPath) as? TableViewCell {
            cell.delegate = self
            cell.fill(product: presenter.products[indexPath.section].products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

//  MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.productSelected(index: indexPath.row)
    }
}

//  MARK: - TableViewCellDelegate

extension MainViewController: TableViewCellDelegate {
    func tableViewCellDidTapBuyButton(_ cell: UITableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        presenter.productBuyButtonTapped(index: index)
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

//  MARK: - UIScrollViewDelegate

extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = tableView.contentOffset.y
        if y > 0 && categoriesController.view.frame.minY > view.safeAreaLayoutGuide.layoutFrame.minY {
            categoriesController.view.frame.origin.y -= y
            tableView.frame.origin.y -= y
        }
        if y < 0 && categoriesController.view.frame.minY < bannerController.view.frame.maxY {
            categoriesController.view.frame.origin.y += -y
            tableView.frame.origin.y += -y
        }
        if categoriesController.view.frame.minY < view.safeAreaLayoutGuide.layoutFrame.minY {
            categoriesController.view.frame.origin.y = view.safeAreaLayoutGuide.layoutFrame.minY
            tableView.frame.origin.y = categoriesController.view.frame.maxY
            bannerController.view.layer.opacity = 0
        }
        if categoriesController.view.frame.minY > bannerController.view.frame.maxY {
            categoriesController.view.frame.origin.y = bannerController.view.frame.maxY
            tableView.frame.origin.y = categoriesController.view.frame.maxY
            bannerController.view.layer.opacity = 1
        }
    }
}
