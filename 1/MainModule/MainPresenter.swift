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
}

protocol MainPresenterProtocol: AnyObject {
    var banners: [UIImage] { get }
    var categories: [String] { get }
    var products: [String] { get }
    func viewLoaded()
    func bannerSelected()
    func categorySelected()
    func productSelected()
}

class MainPresenter: MainPresenterProtocol {
    
    var banners = [UIImage(named: "banner1")!,
                   UIImage(named: "banner2")!,
                   UIImage(named: "banner3")!]
    var categories = ["1","2","3"]
    var products = [""]
    
    func viewLoaded() {
        
    }
    
    func bannerSelected() {
        
    }
    
    func categorySelected() {
        
    }
    
    func productSelected() {
        
    }
}
