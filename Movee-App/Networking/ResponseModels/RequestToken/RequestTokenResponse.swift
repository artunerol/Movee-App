//
//  RequestTokenResponse.swift
//  Movee-App
//
//  Created by Erol, Artun on 15.02.2022.
//

import Foundation

struct RequestTokenResponse: Codable {
    let success: Bool?
    let expiresAt, requestToken: String?

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
