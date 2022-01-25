//
//  MovieDetailResponse.swift
//  Movee-App
//
//  Created by Erol, Artun on 25.01.2022.
//

import Foundation

// MARK: - Welcome
struct MovieDetailResponse: Codable {
    let productionCompanies: [ProductionCompany]?
    let releaseDate: String?
    let runtime: Int?

    enum CodingKeys: String, CodingKey {
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case runtime
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }
}
