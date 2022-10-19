//
//  ProductsController.swift
//  1
//
//  Created by Станислав Зверьков on 19.10.2022.
//

import UIKit

protocol ProductsControllerDelegate: AnyObject {
    func productsController(_ tableViewController: UITableViewController, didSelectProducAt index: Int)
    func productsController(_ tableViewController: UITableViewController, didTapProductBuyButtonAt index: Int)
}

class ProductsController: UITableViewController {
    
    var products: [Product]
    weak var delegate: ProductsControllerDelegate?
    
    init() {
        self.products = []
        super.init(nibName: nil, bundle: nil)
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 15
        tableView.register(UINib(nibName: ProductsCell.identefier, bundle: nil), forCellReuseIdentifier: ProductsCell.identefier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(products: [Product]) {
        self.products = products
        tableView.reloadData()
    }
}

//  MARK: - UItableViewDataSource

extension ProductsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductsCell.identefier, for: indexPath) as? ProductsCell {
            cell.delegate = self
            cell.fill(product: products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

//  MARK: - UItableViewDelegate

extension ProductsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.productsController(self, didSelectProducAt: indexPath.row)
    }
}

//  MARK: - TableViewCellDelegate

extension ProductsController: ProductsCellDelegate {
    func productsCellDidTapBuyButton(_ cell: UITableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        delegate?.productsController(self, didTapProductBuyButtonAt: index)
    }
}
