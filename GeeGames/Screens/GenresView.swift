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
                        .foregroundColor(.red)
                        .shadow(color: .red, radius: 10)
                        .task {
                            await genresViewModel.loadGenres()
                            if let genresList = genresViewModel.genres {
                                genreObjects = genresList
                            }
                        }
                }.tint(.red)
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
                                    .foregroundColor(.black)
                                
                                ImageView(urlString: item.imageBackground)
                                // .frame(width: 320, height: 300)
                                    .edgesIgnoringSafeArea(.all)
                                
                                List {
                                    ForEach(item.games) { game in
                                        NavigationLink {
                                            GameDetailsView(isGenre: true, gameId: game.id)
                                        } label: {
                                            Text(" \(game.name)")
                                                .frame(maxWidth: .infinity, minHeight: 50)
                                                .listRowSeparator(.hidden)
                                            
                                            
                                        }.background(SwiftUI.Color.white)
                                            .listRowSeparator(.hidden)
                                            .background(SwiftUI.Color.clear)
                                    }.listRowSeparator(.hidden)
                                }
                                .frame(height: 300).background(SwiftUI.Color.white)
                            }
                        }
                    }
                }
                .navigationTitle(Text("Genres"))
            }
        }
    }
}

#Preview {
    GenresView()
}
