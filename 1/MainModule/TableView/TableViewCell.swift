//
//  TableViewCell.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func tableViewCellDidTapBuyButton(_ cell: UITableViewCell)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    weak var delegate: TableViewCellDelegate?
    
    @IBAction func byButtonAction(_ sender: Any) {
        delegate?.tableViewCellDidTapBuyButton(self)
    }
    
    func fill(product: Product) {
        imgView.image = product.image
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        buyButton.titleLabel?.text = "from \(product.price) r"
    }
}
