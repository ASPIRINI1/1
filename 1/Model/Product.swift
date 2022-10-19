//
//  Product.swift
//  1
//
//  Created by Станислав Зверьков on 19.10.2022.
//

import Foundation
import UIKit

class Product {
    var id: String
    var title: String
    var description: String
    var price: Int
    var image: UIImage
    
    init(id: String, title: String, description: String, price: Int, image: UIImage) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.image = image
    }
}
