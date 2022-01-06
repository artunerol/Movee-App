//
//  DynamicStringNames.swift
//  Movee-App
//
//  Created by Artun Erol on 5.01.2022.
//

import Foundation

struct StaticStringsList {
    
    //MARK: - CollectionView
    
    static let popularMoviesReusableHeader = "PopularMoviesHeader"
    static let popularMoviesCollectionViewCellIdentifier = "PopularMoviesCollectionViewCell"
    
    //MARK: - NotificationCenter
    
    static let apiDataObserver = "DataReceived"
    
    //MARK: - NetworkManager
    
    static private let myAPIKey = "d9887848cba0ebdfebd5a3088a951f3b"
    
    static let myURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(myAPIKey)&language=en-US&page=1"
    
}
