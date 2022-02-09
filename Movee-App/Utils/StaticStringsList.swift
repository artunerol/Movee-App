//
//  DynamicStringNames.swift
//  Movee-App
//
//  Created by Artun Erol on 5.01.2022.
//

import Foundation

struct StaticStringsList {
    // MARK: - NetworkManager
    
    static private let myAPIKey = "d9887848cba0ebdfebd5a3088a951f3b"
    static let baseURL = "https://api.themoviedb.org"
    static let imageBaseURL = "https://image.tmdb.org"

    static let apiKeyParam = "?api_key=\(myAPIKey)&language=en-US&page=1"
}

enum ServiceURL {
    // URL = "https://api.themoviedb.org/3/movie/popular?api_key=d9887848cba0ebdfebd5a3088a951f3b&language=en-US&page=1"
    case populerMoviesURL
    case topRatedTVSeriesURL

    case movieCast(String)
    case tvCast(String)
    case tvDetail(String)
    case movieDetail(String)
    case person(Int)
    case search(String)

    
    case originalPoster
    case w500Poster
    //  "https://api.themoviedb.org/3/tv/85552?api_key=d9887848cba0ebdfebd5a3088a951f3b&language=en-US&page=1"
    // mock detailPageTVSeris:  https://api.themoviedb.org/3/tv/85552/credits?api_key=d9887848cba0ebdfebd5a3088a951f3b&language=en-US&page=1
    
    var description: String {
        switch self {
        case .populerMoviesURL:
            return  "/3/movie/popular"
        case .topRatedTVSeriesURL:
            return "/3/tv/popular"
        case .movieCast(let id):
            return "/3/movie/\(id)/credits"
        case .tvCast(let id):
            return "/3/tv/\(id)/credits"
        case .originalPoster:
            return "/t/p/original"
        case .w500Poster:
            return "/t/p/w500"
        case .tvDetail(let id):
            return "/3/tv/\(id)"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .person(let id):
            return "/3/person/\(id)"
        case .search(let keyword):
            return "/3/search/multi" + StaticStringsList.apiKeyParam + "&query=\(keyword.removeSpaces().lowercased())&include_adult=false"
        }
    }
}
