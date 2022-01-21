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
        let movieViewModel = MoviesTabMainViewModel()
        movieViewController.viewModel = movieViewModel
        movieViewController.tabBarItem.image = UIImage(named: "tabBarMovies")

        let tvSeriesViewController = TVSeriesMainTabViewController(nibName: "TVSeriesMainTabViewController", bundle: nil)
        let tvSeriesViewModel = TVSeriesViewModel()
        tvSeriesViewController.viewModel = tvSeriesViewModel
        tvSeriesViewController.tabBarItem.image = UIImage(named: "tabBarTVSeries")
        
        tabBar.viewControllers = [movieViewController, tvSeriesViewController]
        return tabBar
    }
}
