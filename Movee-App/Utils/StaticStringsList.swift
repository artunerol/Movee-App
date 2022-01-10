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
    static let imageBaseURL = "https://image.tmdb.org"

    static let apiKeyParam = "api_key=\(myAPIKey)&language=en-US&page=1"
}

enum ServiceURL: String {
    //URL = "https://api.themoviedb.org/3/movie/popular?api_key=d9887848cba0ebdfebd5a3088a951f3b&language=en-US&page=1"
    
    case populerMoviesURL = "/3/movie/popular"
    
    case popularMoviesOriginalPoster = "/t/p/original"
    case popularMoviesW500Poster = "/t/p/w500"
}
