//
//  CastResponse.swift
//  Movee-App
//
//  Created by Erol, Artun on 21.01.2022.
//

import Foundation

class CastResponse: Codable {
    let id: Int?
    let cast: [CastResultResponse]?
    let crew: [CrewResultResponse]?
}

// MARK: - Cast
struct CastResultResponse: Codable {
    let id: Int?
    let name: String?
    let profilePath: String?
    let castID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case castID = "cast_id"
    }
}

struct CrewResultResponse: Codable {
    let job: String?

    enum CodingKeys: String, CodingKey {
        case job
    }
}
