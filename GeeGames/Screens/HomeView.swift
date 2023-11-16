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
    
    @State var searchText: String = ""
    
    @State var filteredObjects: [Game] = []
    
    var body: some View {
        
        // MARK: Emty View
        if dataDidLoad == false {
            Text("Loading...").font(.system(size: 40, weight: .bold))
                .foregroundColor(.red)
                .shadow(color: .red, radius: 10)
                .task {
                    await viewModel.loadGames()
                    filteredObjects = viewModel.gamesInfo
                    dataDidLoad = true
                }
                
        } else {
          
            NavigationView {
                
                VStack {
                    List {
                        ForEach(filteredObjects) { item in
                            
                            VStack(alignment: .center, spacing: 20) {
                                
                                // MARK: - Game Name
                                Text("\(item.name)")
                                    .font(.system(size: 18, weight: .semibold))
                                    .shadow(color: .gray, radius: 5).listRowSeparator(.hidden)
                                
                                // MARK: - Poster
                                NavigationLink {
                                    GameDetailsView(game: item)
                                } label: {
                                    ImageView(urlString: item.backgroundImage)
                                        .frame(width: 320, height: 300)
                                        
                                }
                                
                                // MARK: - Rating
                                RatingView(rating: Int(item.rating)).listRowSeparator(.hidden)
                                
                                Spacer()
                                
                            }.listRowSeparator(.hidden)
                            //.border(SwiftUI.Color.gray).cornerRadius(3.0)
                                .background(SwiftUI.Color.white)
                            
                        }
                    }
                   // .frame(minWidth: .infinity)
                   // .edgesIgnoringSafeArea(.all)
                    .listStyle(GroupedListStyle())
                    .listRowBackground(SwiftUI.Color.clear)
                    
                    // MARK: - Networking / Business
                }
                .navigationTitle("Top Games [\(viewModel.data.count)]")
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
            }.searchable(text: $searchText,
                         placement: .automatic,
                         prompt: "Search games...")
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
