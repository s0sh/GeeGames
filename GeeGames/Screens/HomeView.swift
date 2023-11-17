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
                        .foregroundColor(.red)
                        .shadow(color: .red, radius: 10)
                        .task {
                            await viewModel.loadGames()
                            filteredObjects = viewModel.gamesInfo
                            dataDidLoad = true
                        }
                }.tint(.red)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(SwiftUI.Color("AccentColor"))
                
        } else {
          
            NavigationView {
                VStack {
                    List {
                        ForEach(filteredObjects) { item in
                            VStack(alignment: .center, spacing: 20) {

                                
                                // MARK: - Game Name
                                
                                Text("\(item.name)")
                                    .font(.system(size: 22, weight: .black))
                                    .foregroundColor(.red)
                                    .shadow(color: .red, radius: 5).listRowSeparator(.hidden)
                                    
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
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    
                                    
                                }
                                
                               // Text("").frame(maxWidth: .infinity, maxHeight: 0.3).background(SwiftUI.Color.black)
                                
                            }.listRowSeparator(.hidden)
                             .background(SwiftUI.Color.white)
                        }
                    }
                   // .frame(minWidth: .infinity)
                   // .edgesIgnoringSafeArea(.all)
                    .listStyle(GroupedListStyle())
                    .listRowBackground(SwiftUI.Color.clear)
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
            }
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
            
        if filteredObjects.count > 0 {
            MenuView()
        }
    
    }
}

#Preview {
    HomeView()
}
