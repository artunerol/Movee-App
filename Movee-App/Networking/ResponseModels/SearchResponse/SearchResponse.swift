// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct SearchAPIResponse: Codable {
    let results: [SearchResultAPIResponse]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct SearchResultAPIResponse: Codable {
    let id: Int?
    let mediaType: MediaType?
    let posterPath, title: String?
    let name: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case title
        case name
        case profilePath = "profile_path"
    }
}

enum MediaType: String, Codable {
    case tvision = "tv"
    case movie
    case person
    case defaultType

    var description: String {
        switch self {
        case .movie:
            return "Movie"
        case .person:
            return "Person"
        case .tvision:
            return "TV Series"
        case .defaultType:
            return ""
        }
    }
}
