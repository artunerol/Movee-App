//
//  TVSeriesDetailResponse.swift
//  Movee-App
//
//  Created by Erol, Artun on 24.01.2022.
//

import Foundation

// MARK: - Welcome
struct TVSeriesDetailResponse: Codable {
    let createdBy: [CreatedBy]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let lastAirDate: String?
    let numberOfEpisodes, numberOfSeasons: Int?

    enum CodingKeys: String, CodingKey {
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
    }
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: Int?
    let name: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
