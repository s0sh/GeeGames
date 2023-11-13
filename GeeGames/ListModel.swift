//
//  ListModel.swift
//  GeeGames
//
//  Created by Roman Bigun on 13.11.2023.
//

import Foundation

import Foundation

// MARK: - Games
struct Games: Codable {
    let next: String?
    let previous: String?
    let results: [Game]?
}

// MARK: - Result
struct Game: Identifiable, Codable {
    let id: Int
    let slug, name, released: String?
    let tba: Bool?
    let background_image: String?
    let rating, rating_top: Double?
  //  let ratings: AddedByStatus?
    let ratings_count: Int?
    let reviews_text_count: String?
    let added: Int?
   // let added_by_status: AddedByStatus?
    let metacritic, playtime, suggestions_count: Int?
    let esrb_rating: EsrbRating?
    let platforms: [Platform]?
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let slug, name: String
}

// MARK: - Platform
struct Platform: Codable {
    let platform: EsrbRating?
    let released_at: String?
    let requirements: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case released_at = "released_at"
        case requirements
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    let minimum, recommended: String
}
