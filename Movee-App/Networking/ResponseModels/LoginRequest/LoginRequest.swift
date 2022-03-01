//
//  LoginRequest.swift
//  Movee-App
//
//  Created by Erol, Artun on 1.03.2022.
//

import Foundation

struct LoginRequest: Codable {
    let username, password, requestToken: String?

    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
}

