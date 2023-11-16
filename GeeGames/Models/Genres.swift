//
//  Genres.swift
//  GeeGames
//
//  Created by Roman Bigun on 16.11.2023.
//

import Foundation

// MARK: - Genres
struct Genres: Codable {
    let count: Int
    let next, previous: String?
    let results: [Results]
}

// MARK: - Result
struct Results: Identifiable, Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let games: [GenreGame]
}

// MARK: - Game
struct GenreGame: Identifiable, Codable {
    let id: Int
    let slug, name: String
    let added: Int
}
