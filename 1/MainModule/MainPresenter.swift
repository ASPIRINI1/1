//
//  MainPresenter.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func scrollTo(section: Int)
    func reloadProducts()
    func reloadCategories()
}

protocol MainPresenterProtocol: AnyObject {
    var banners: [UIImage] { get }
    var categories: [String] { get }
    var products: [(category: String, products: [Product])] { get }
    func viewLoaded()
    func bannerSelected(index: Int)
    func categorySelected(index: Int)
    func productSelected(index: Int)
    func productBuyButtonTapped(index: Int)
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var networkService: FireAPIProtocol
    var banners = [UIImage(named: "banner1")!,
                   UIImage(named: "banner2")!,
                   UIImage(named: "banner3")!]
    var categories:[String] = []
    var products: [(category: String, products: [Product])] = []
    
    init(view: MainViewProtocol, networkService: FireAPIProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func viewLoaded() {
        networkService.getProucts { [weak self] products in
            self?.products = products ?? []
            self?.view?.reloadProducts()
            guard let products = products else { return }
            for category in products {
                self?.categories.append(category.category)
                self?.view?.reloadCategories()
                for product in category.products {
                    self?.networkService.getImage(in: category.category, for: product.id, completion: { [weak self] image in
                        product.image = image
                        self?.view?.reloadProducts()
                    })
                }
            }
        }
    }
    
    func bannerSelected(index: Int) {
        
    }
    
    func categorySelected(index: Int) {
        view?.scrollTo(section: index)
    }
    
    func productSelected(index: Int) {
        
    }
    
    func productBuyButtonTapped(index: Int) {
        
    }
}
