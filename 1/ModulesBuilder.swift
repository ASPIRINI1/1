//
//  ModulesBuilder.swift
//  1
//
//  Created by Станислав Зверьков on 18.10.2022.
//

import Foundation
import UIKit

protocol ModulesBuilderProtocol {
    static func createMainViewController() -> UIViewController
}

class ModulesBuilder: ModulesBuilderProtocol {
    static func createMainViewController() -> UIViewController {
        return MainViewController()
    }
}
