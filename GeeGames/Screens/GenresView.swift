//
//  SettingsView.swift
//  GeeGames
//
//  Created by Roman Bigun on 15.11.2023.
//

import SwiftUI

struct GenresView: View {
    
    @State private var genreObjects: [Results] = []
    
    @StateObject private var genresViewModel = GenreViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(genreObjects) { item in
                    Section {
                        VStack {
                            Text("\(item.name)")
                               
                            ImageView(urlString: item.imageBackground)
                                .frame(width: 320, height: 300)
                                .edgesIgnoringSafeArea(.all)
                            List {
                                ForEach(item.games) { game in
                                    NavigationLink {
                                        GameDetailsView(isGenre: true, gameId: game.id)
                                    } label: {
                                        Text(" \(game.name)")
                                            .frame(maxWidth: .infinity, minHeight: 50)
                                            .background(SwiftUI.Color("main"))
                                            .shadow(color: Settings.shadowColor, radius: Settings.shadowRadius)
                                        
                                    }
                                }
                            }.frame(height: 300)
                        }
                    }
                }
            }.navigationTitle(Text("Genres"))
        }
        .task {
            await genresViewModel.loadGenres()
            if let genresList = genresViewModel.genres {
                genreObjects = genresList
            }
        }
    }
}

#Preview {
    GenresView()
}
