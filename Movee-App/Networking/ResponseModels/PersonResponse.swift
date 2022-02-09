// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - PersonAPIRESponse
struct PersonAPIResponse: Codable {
    let biography, birthday: String
    let id: Int
    let name, placeOfBirth: String
    let profilePath: String

    enum CodingKeys: String, CodingKey {        
        case biography, birthday, id
        case name
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
    }
}
