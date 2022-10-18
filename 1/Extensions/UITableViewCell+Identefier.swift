//
//  UITableViewCell+Identefier.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identefier: String {
        get {
            return String.init(describing: self)
        }
    }
}
