//
//  ContentView.swift
//  GeeGames
//
//  Created by Roman Bigun on 13.11.2023.
//

import SwiftUI

struct HomeContainerView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        HomeView(onCommit: fetch, gameObjects: store.state.loadedGames)
            .onAppear(perform: fetch)
        
    }
    
    private func fetch() {
        store.send(.getGameInfo)
    }
}

struct HomeView: View {
    
    let onCommit: (() -> Void)?
    
    
    @State private var searchText: String = ""
    @State private var dataDidLoad: Bool = false
    @State var gameObjects: [Game] = []
    @State var isPrev: Bool?
    
    @StateObject private var viewModel = GamesListViewModel()
    
    var body: some View {
        
        // MARK: Emty View
        if dataDidLoad == false {
            VStack {
                ProgressView {
                    Text("Loading...").font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                        .shadow(color: .blue, radius: 10)
                        .task {
                            onCommit?()
                            gameObjects = []
                            await viewModel.loadGames()
                            gameObjects = viewModel.gamesInfo
                            dataDidLoad = true
                        }
                }.tint(.blue)
                    .onAppear {
                        UserDefaults.standard.setValue(true, forKey: "tearms_tapped")
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                SwiftUI.Color("AccentColor").ignoresSafeArea()
            }
        }
        else {
            
            NavigationView {
                VStack {
                    List {
                        ForEach(gameObjects) { item in
                            VStack(alignment: .center, spacing: 20) {
                                
                                // MARK: - Name
                                Text("\(item.name)")
                                    .font(.system(size: 22, weight: .black))
                                    .foregroundColor(.blue)
                                    .shadow(color: .blue, radius: 5).listRowSeparator(.hidden)
                                
                                // MARK: - Poster
                                
                                NavigationLink {
                                    GameDetailsView(game: item)
                                } label: {
                                    ImageView(urlString: item.backgroundImage)
                                        .frame(minHeight: 350)
                                }
                                
                                // MARK: - Rating
                                HStack {
                                    
                                    RatingView(rating: Int(item.rating))
                                        .listRowSeparator(.hidden)
                                        .padding(.all)
                                    
                                    Text("Reviews: \(item.reviewsCount)")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                            }.listRowSeparator(.hidden)
                        }
                        
                        // MARK: -  Load More...
                        if viewModel.isMoreDataAvailable {
                            HStack {
                                Button {
                                    Task {
                                        await viewModel.loadNextPage()
                                        gameObjects = viewModel.gamesInfo
                                    }
                                } label: {
                                    Text("Load more...")
                                        .frame(maxWidth: .infinity, maxHeight: 60)
                                        .background(SwiftUI.Color.blue)
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                        .cornerRadius(14)
                                }
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .preferredColorScheme(.dark)
                }
                // MARK: - Navigation bar
                .navigationBarItems(leading: Text("Games")
                .font(.system(size: 24, weight: .bold)))
                .foregroundColor(SwiftUI.Color.white)
            }.accentColor(.blue)
            // MARK: - Search bar
                .searchable(text: $searchText, placement: .automatic, prompt: "Search games...")
                .onChange(of: searchText) { searchText in
                    if !searchText.isEmpty {
                        gameObjects = viewModel.gamesInfoFiltered.filter { $0.name.contains(searchText) }
                    } else {
                        gameObjects = viewModel.gamesInfo
                    }
                }
        }
    }
}
