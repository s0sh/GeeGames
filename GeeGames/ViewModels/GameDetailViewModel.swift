//
//  GameDetailViewModel.swift
//  GeeGames
//
//  Created by Roman Bigun on 15.11.2023.
//

import Foundation
import SwiftUI

@MainActor
class GamesDetailViewModel: ObservableObject {
    
    @Published var gamesInfo: GameDetails?
    
    @Published var id: Int = 0
    
    func loadInfo() async {
        do {
            let info = try await loadGameInfo()
            gamesInfo = info
        } catch {
            print("Could load photos: \(error)")
        }
    }
    
    private
    func loadGameInfo() async -> GameDetails? {
        do {
            let url = URL(string: mainUrl + "/\(id)" + "?key=" + authKey)!
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return nil
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(GameDetails.self, from: data)
            // MARK: Result
            return decodedResponse
            
        } catch {
            print(error)
            return nil
        }
    }
}
