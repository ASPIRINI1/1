//
//  MainPresenter.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func scrollTo()
    func reloadProducts()
}

protocol MainPresenterProtocol: AnyObject {
    var banners: [UIImage] { get }
    var categories: [String] { get }
    var products: [Product] { get }
    func viewLoaded()
    func bannerSelected(index: Int)
    func categorySelected(index: Int)
    func productSelected(index: Int)
    func productBuyButtonTapped(index: Int)
}

class MainPresenter: MainPresenterProtocol {
    
    var view: MainViewProtocol
    var networkService: FireAPIProtocol
    var banners = [UIImage(named: "banner1")!,
                   UIImage(named: "banner2")!,
                   UIImage(named: "banner3")!]
    var categories = ["Пицца","Комбо","Десерты", "Напитки"]
    var products: [Product] = []
    
    init(view: MainViewProtocol, networkService: FireAPIProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func viewLoaded() {
        networkService.getProucts { [weak self] products in
            guard let products = products else { return }
            self?.products = products
            self?.view.reloadProducts()
            for product in products {
                self?.networkService.getImage(forID: product.id) { [weak self] image in
                    product.image = image
                    self?.view.reloadProducts()
                }
            }
        }
    }
    
    func bannerSelected(index: Int) {
        
    }
    
    func categorySelected(index: Int) {
            
    }
    
    func productSelected(index: Int) {
        
    }
    
    func productBuyButtonTapped(index: Int) {
        
    }
}
