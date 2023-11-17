//
//  GameDescriptionModel.swift
//  GeeGames
//
//  Created by Roman Bigun on 15.11.2023.
//

import Foundation

// MARK: - GameDetails
struct GameDetails: Codable {
    let id: Int
    let slug, name, nameOriginal, description: String
    let metacritic: Int
    let released: String
    let tba: Bool
    let updated: String
    let backgroundImage, backgroundImageAdditional: String
    let website: String
    let rating: Double
    let ratingTop: Int
    let redditName, redditDescription, redditLogo: String
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let clip: String?
    let descriptionRaw: String
}
