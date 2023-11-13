//
//  ContentView.swift
//  GeeGames
//
//  Created by Roman Bigun on 13.11.2023.
//

import SwiftUI

let gamesListUrl = URL(string: "https://api.rawg.io/api/games?key=a716c6cb697f47dfa96b5013504dc76c")!

struct ContentView: View {
    
    @State private var gamesInfo: [Game] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(gamesInfo) { _ in
                    VStack {
                        AsyncImage(url: URL(string: $0.background_image ?? "")!) { phase in
                            switch phase {
                            case .success(let image):
                                image
                            case .failure(let error):
                                let _ = print(error)
                                Text("error: \(error.localizedDescription)")
                            case .empty:
                                ProgressView()
                            @unknown default:
                                fatalError()
                            }
                        }
                    }
                    ZStack {
                        Text("\($0.name!)")
                    }
                }
            }
        }
        .task {
            await loadItems()
        }
    }
    
    func loadImage() {
        
    }
    
    func loadItems() async {
        do {
            let (data, response) = try await URLSession.shared.data(from: gamesListUrl)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(Games.self, from: data)
            
            // MARK: Result
            gamesInfo = decodedResponse.results ?? []
            
        } catch { print(error) }
    }
    
}

#Preview {
    ContentView()
}
