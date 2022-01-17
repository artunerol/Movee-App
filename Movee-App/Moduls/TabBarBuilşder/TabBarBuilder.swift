//
//  TabBarBuilder.swift
//  Movee-App
//
//  Created by Erol, Artun on 17.01.2022.
//

import Foundation
import UIKit

class TabBarBuilder {
    static let shared = TabBarBuilder()
    
    func build() -> UITabBarController {
        let tabBar = UITabBarController()
        let movieViewController = MoviesTabMainViewController.init(nibName: "MoviesTabMainViewController", bundle: nil)
        let viewModel = MoviesTabMainViewModel()
        movieViewController.viewModel = viewModel
        movieViewController.tabBarItem.image = UIImage(named: "tabBarMovies")
        
        tabBar.viewControllers = [movieViewController]
        return tabBar
    }
}
