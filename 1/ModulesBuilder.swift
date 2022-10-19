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
        let view = MainViewController()
        let networkManager = FireAPI.shared
        let presenter = MainPresenter(view: view, networkService: networkManager)
        view.presenter = presenter
        return view
    }
}
