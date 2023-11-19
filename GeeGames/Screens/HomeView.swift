//
//  ContentView.swift
//  GeeGames
//
//  Created by Roman Bigun on 13.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    @State var isPrev: Bool?
    
    @State var dataDidLoad: Bool = false
    
    @StateObject private var viewModel = GamesListViewModel()
    
    @State private var searchText: String = ""
    
    @State private var filteredObjects: [Game] = []
    
    var body: some View {
        
        // MARK: Emty View
        if dataDidLoad == false {
            
            VStack {
                ProgressView {
                    Text("Loading...").font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                        .shadow(color: .blue, radius: 10)
                        .task {
                            filteredObjects = []
                            await viewModel.loadGames()
                            filteredObjects = viewModel.gamesInfo
                            dataDidLoad = true
                        }
                }.tint(.blue)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                SwiftUI.Color("AccentColor")
                    .ignoresSafeArea()
            }
            
        } else {
            
            NavigationView {
                VStack {
                    List {
                        ForEach(filteredObjects) { item in
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
                    }.listStyle(GroupedListStyle())
                    .preferredColorScheme(.dark)
                }
                // MARK: - Networking / Business
                .task {
                    if dataDidLoad == true && isPrev != nil {
                        if isPrev == false {
                            await viewModel.loadNextPage()
                            filteredObjects = viewModel.gamesInfo
                            dataDidLoad = true
                        } else if isPrev == true {
                            await viewModel.loadPrevPage()
                            filteredObjects = viewModel.gamesInfo
                            dataDidLoad = true
                        } else {
                            await viewModel.loadGames()
                            filteredObjects = viewModel.gamesInfo
                            dataDidLoad = true
                        }
                    }
                }
                // MARK: - Navigation bar
                .navigationBarItems(leading: Text("Games")
                    .font(.system(size: 18, weight: .bold)))
                .foregroundColor(
                    SwiftUI.Color("AccentColor")
                        //.ignoresSafeArea()
                )
            }.accentColor(.blue)
            // MARK: - Search bar
            .searchable(text: $searchText, placement: .automatic, prompt: "Search games...")
            .onChange(of: searchText) { searchText in
                if !searchText.isEmpty {
                    filteredObjects = viewModel.gamesInfoFiltered.filter { $0.name.contains(searchText) }
                } else {
                    filteredObjects = viewModel.gamesInfo
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
