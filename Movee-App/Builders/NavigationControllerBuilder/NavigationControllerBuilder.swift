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
        var rootVC = UIViewController()
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            rootVC = TabBarBuilder.shared.build()
        } else {
            let viewModel = LoginViewModel()
            let loginVC = LoginViewController(nibName: LoginViewController.nameOfClass, bundle: nil)
            loginVC.viewModel = viewModel
            rootVC = loginVC
        }
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.navigationBar.backIndicatorImage = UIImage(named: "arrowBack")
        navigationVC.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowBack")
        navigationVC.navigationBar.tintColor = .white
        return navigationVC
    }
}
