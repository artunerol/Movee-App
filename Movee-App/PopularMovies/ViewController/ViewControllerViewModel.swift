//
//  ViewControllerViewModel.swift
//  Movee-App
//
//  Created by Artun Erol on 7.01.2022.
//

import UIKit

class ViewControllerViewModel {
    
    private let networkManager = NetworkManager()
    var movieResultArray = [APIResult]()
    
    init() {
        networkManager.fetchData(as: APIData.self) { [weak self] result in
            self?.movieResultArray = result.results
            NotificationCenter.default.post(name: .apiDataObserver(), object: nil)
        }
    }
    
}


