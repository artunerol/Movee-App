//
//  CastResponse.swift
//  Movee-App
//
//  Created by Erol, Artun on 21.01.2022.
//

import Foundation

struct CastResponse: Codable {
    let id: Int?
    let cast: [CastResultResponse]?
    let crew: [CastResultResponse]?
}

// MARK: - Cast
struct CastResultResponse: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

struct CrewResultResponse: Codable {
    let job: String?

    enum CodingKeys: String, CodingKey {
        case job
    }
}
