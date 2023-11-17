//
//  GenreViewModel.swift
//  GeeGames
//
//  Created by Roman Bigun on 16.11.2023.
//

import Foundation

@MainActor
class GenreViewModel: ObservableObject {
    
    @Published var genres: [Results]?
    
    private let settings: OperationslData = OperationslData.shared
    
    func loadGenres() async {
        do {
            let gamesByGenres = try await loadItems()
            genres = gamesByGenres
        } catch {
            print("Could load photos: \(error)")
        }
    }
    
    private
    func loadItems() async -> [Results] {
        do {
            let (data, response) = try await URLSession.shared.data(from: URL(string: settings.genresListUrlString)!)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return []
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(Genres.self, from: data)
            
            // MARK: Result
            return decodedResponse.results
            
        } catch {
            print(error)
            return []
        }
    }
    
    
}
