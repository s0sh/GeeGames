//
//  GamesListViewModel.swift
//  GeeGames
//
//  Created by Roman Bigun on 14.11.2023.
//

import Foundation
import SwiftUI

@MainActor
class GamesListViewModel: ObservableObject {
    
    @Published var gamesInfo: [Game] = []
    
    func loadGames() async {
        do {
            let games = try await GamesManager.loadItems()
            gamesInfo = games
        } catch {
            print("Could load photos: \(error)")
        }
    }
}

fileprivate
struct GamesManager {
    
    static func loadItems() async -> [Game] {
        do {
            let (data, response) = try await URLSession.shared.data(from: gamesListUrl)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return []
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(Games.self, from: data)
            
            // MARK: Result
            return decodedResponse.results ?? []
            
        } catch {
            print(error)
            return []
        }
    }
    
}

