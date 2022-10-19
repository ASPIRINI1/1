//
//  TableViewCell.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func tableViewCell(_ cell: UITableViewCell, didSelectProductForID productID: String)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var byButton: UIButton!
    
    weak var delegate: TableViewCellDelegate?
    var productID: String!
    
    @IBAction func byButtonAction(_ sender: Any) {
        delegate?.tableViewCell(self, didSelectProductForID: productID)
    }
    
    func fill(product: Product) {
        productID = product.id
        imageView?.image = product.image
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        byButton.setTitle("от \(product.price) р", for: .normal)
    }
}
