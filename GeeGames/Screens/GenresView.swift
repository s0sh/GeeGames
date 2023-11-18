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
        if genreObjects.count == 0 {
            VStack {
                ProgressView {
                    Text("Loading...").font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                        .shadow(color: .blue, radius: 10)
                        .task {
                            await genresViewModel.loadGenres()
                            if let genresList = genresViewModel.genres {
                                genreObjects = genresList
                            }
                        }
                }.tint(.blue)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(SwiftUI.Color("AccentColor"))
        } else {
            NavigationView {
                List {
                    ForEach(genreObjects) { item in
                        Section {
                            VStack {
                                Text("\(item.name)")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.white)
                                    .shadow(color: .white, radius: 5)
                                ImageView(urlString: item.imageBackground)
                                // .frame(width: 320, height: 300)
                                    .edgesIgnoringSafeArea(.all)
                                
                                List {
                                    ForEach(item.games) { game in
                                        NavigationLink {
                                            GameDetailsView(isGenre: true, gameId: game.id)
                                        } label: {
                                            Text(" \(game.name)")
                                                .frame(maxWidth: .infinity, minHeight: 35)
                                                .listRowSeparator(.hidden)
                                                .foregroundColor(SwiftUI.Color("AccentColor"))
                                            
                                            
                                        }.background(SwiftUI.Color.white)
                                            .listRowSeparator(.hidden)
                                            .background(SwiftUI.Color.clear)
                                    }.listRowSeparator(.hidden)
                                }
                                .frame(height: 300).background(SwiftUI.Color("AccentColor"))
                                
                            }
                        }.background(SwiftUI.Color("AccentColor"))
                    }
                }
                .navigationTitle(Text("Genres").foregroundColor(.blue))
                
            }.accentColor(.blue)
        }
    }
}

#Preview {
    GenresView()
}
