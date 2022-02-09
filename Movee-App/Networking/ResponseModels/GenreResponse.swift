//
//  GenreResponse.swift
//  Movee-App
//
//  Created by Erol, Artun on 28.01.2022.
//

import Foundation

// MARK: - Welcome
struct GenreResponse: Codable {
    let genres: [GenreResultResponse]
}

// MARK: - Genre
struct GenreResultResponse: Codable {
    let id: Int
    let name: String
}
