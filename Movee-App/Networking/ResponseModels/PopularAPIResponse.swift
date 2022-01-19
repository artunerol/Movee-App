//
//  PopulerMoviesResponse.swift
//  Movee-App
//
//  Created by Ismail Kilic on 7.01.2022.
//


import Foundation

// MARK: - PopulerMoviesResponse
struct PopularAPIResponse: Codable {
    let page: Int?
    let results: [PopularAPIResultResponse]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PopularAPIResultResponse: Codable {
    let genreIDS: [Int]?
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let originalTitle: String?
    let voteAverage, popularity: Double?
    let posterPath, overview, title: String?
    let voteCount: Int?
    let releaseDate: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case popularity
        case posterPath = "poster_path"
        case overview, title
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case video
    }
}
