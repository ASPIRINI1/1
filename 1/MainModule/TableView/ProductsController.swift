//
//  ProductsController.swift
//  1
//
//  Created by Станислав Зверьков on 19.10.2022.
//

import UIKit

protocol ProductsControllerDelegate: AnyObject {
    func  productsController(_ tableViewController: UITableViewController, didSelectProductForIndex: Int)
}

class ProductsController: UITableViewController {
    
    var products: [String]!
    weak var delegate: ProductsControllerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.products = []
        tableView.register(UINib(nibName: TableViewCell.identefier, bundle: nil), forCellReuseIdentifier: TableViewCell.identefier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProductsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identefier, for: indexPath) as? TableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}

extension ProductsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.productsController(self, didSelectProductForIndex: indexPath.row)
    }
}
