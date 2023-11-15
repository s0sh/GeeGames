//
//  GamesListViewModel.swift
//  GeeGames
//
//  Created by Roman Bigun on 14.11.2023.
//

import Foundation
import SwiftUI

let authKey = "a716c6cb697f47dfa96b5013504dc76c"
let mainUrl = "https://api.rawg.io/api/games"

class OperationslData {
    static let shared = OperationslData()
    
    let gamesListUrlString = mainUrl + "?key=" + authKey
    var nextUrl = ""
    var prevUrl = ""
    var count = 0
}

@MainActor
class GamesListViewModel: ObservableObject {
    
    @Published var gamesInfo: [Game] = []
    let data: OperationslData = OperationslData.shared
    var count: Int = 0
    
    
    func loadGames() async {
        do {
            let games = try await loadItems(by: data.gamesListUrlString)
            gamesInfo = games
        } catch {
            print("Could load photos: \(error)")
        }
    }
    
    func loadNextPage() async {
        do {
            let games = try await loadItems(by: data.nextUrl)
            gamesInfo = games
        } catch {
            print("Couldn't load photos: \(error)")
        }
    }
    
    func loadPrevPage() async {
        if !data.prevUrl.isEmpty {
            do {
                let games = try await loadItems(by: data.prevUrl)
                gamesInfo = games
            } catch {
                print("Couldn't load photos: \(error)")
            }
        }
    }
    
    private
    func loadItems(by urlString: String) async -> [Game] {
        do {
            let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return []
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(Games.self, from: data)
            self.data.nextUrl = decodedResponse.next
            if let previous = decodedResponse.previous {
                self.data.prevUrl = previous
            }
            // MARK: Result
            count = decodedResponse.count
            self.data.count = count
            return decodedResponse.results ?? []
            
        } catch {
            print(error)
            return []
        }
    }
}

