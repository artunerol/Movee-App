//
//  NavigationControllerBuilder.swift
//  Movee-App
//
//  Created by Erol, Artun on 21.01.2022.
//

import Foundation
import UIKit

class NavigationControllerBuilder {
    static let shared = NavigationControllerBuilder()

    func build() -> UINavigationController {
        let rootVC = TabBarBuilder.shared.build()
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.navigationBar.backIndicatorImage = UIImage(named: "arrowBack")
        navigationVC.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowBack")
        navigationVC.navigationBar.tintColor = .white
        return navigationVC
    }
}
