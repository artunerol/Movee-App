//
//  PopularMoviesViewModel.swift
//  Movee-App
//
//  Created by Ismail Kilic on 7.01.2022.
//

import Foundation

class PopularMoviesViewModel {

    private let networkManager = NetworkManager()
    var movieResultArray = [APIResult]()

    init() {
        networkManager.fetchData(as: APIData.self) { [weak self] result in
            self?.movieResultArray = result.results
            NotificationCenter.default.post(name: .apiDataObserver(), object: nil)
        }
    }
}
