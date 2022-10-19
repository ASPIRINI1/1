//
//  TableViewCell.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

protocol ProductsCellDelegate: AnyObject {
    func productsCellDidTapBuyButton(_ cell: UITableViewCell)
}

class ProductsCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    weak var delegate: ProductsCellDelegate?
    
    @IBAction func byButtonAction(_ sender: Any) {
        delegate?.productsCellDidTapBuyButton(self)
    }
    
    func fill(product: Product) {
        imgView.image = product.image
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        buyButton.titleLabel?.text = "от \(product.price) р"
    }
}
