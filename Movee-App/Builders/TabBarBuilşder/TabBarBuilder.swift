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

        let searchViewController = SearchViewController(nibName: SearchViewController.nameOfClass, bundle: nil)
        let searchViewModel = SearchViewModel()
        searchViewController.viewModel = searchViewModel
        searchViewController.tabBarItem.image = UIImage(named: "searchBarIcon")

        let profileViewController = ProfileViewController(nibName: ProfileViewController.nameOfClass, bundle: nil)
        profileViewController.tabBarItem.image = UIImage(named: "iconsTabbarProfil")

        tabBar.viewControllers = [movieViewController, tvSeriesViewController, searchViewController, profileViewController]
        return tabBar
    }
}
