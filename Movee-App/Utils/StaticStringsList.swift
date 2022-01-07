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
    
    //MARK: - NotificationCenter
    
    static let apiDataObserver = "DataReceived"
    
    //MARK: - NetworkManager
    
    static private let myAPIKey = "d9887848cba0ebdfebd5a3088a951f3b"
    static let baseURL = "https://api.themoviedb.org"


    static let apiKeyParam = "api_key=\(myAPIKey)&language=en-US&page=1"
    
}

enum ServiceURL: String {
    case populerMoviesURL = "/3/movie/popular"
}
