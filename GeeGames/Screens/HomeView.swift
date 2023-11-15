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
    
    var body: some View {
        
        // MARK: Emty View
        if dataDidLoad == false {
            Text("Loading...").font(.system(size: 40, weight: .bold))
                .foregroundColor(.red)
                .shadow(color: .red, radius: 10)
                .task {
                    await viewModel.loadGames()
                    dataDidLoad = true
                }
                
        } else {
          
            NavigationView {
                VStack {
                    SearchView().frame(width: .infinity, height: 40)
                    List {
                        ForEach(viewModel.gamesInfo) { item in
                            VStack(alignment: .center, spacing: 20) {
                                
                             //   Spacer()
                                
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
                    }.listRowBackground(SwiftUI.Color.clear)
                    
                    // MARK: - Networking / Business
                }.navigationTitle("Top Games [\(viewModel.data.count)]")
                    .task {
                        if dataDidLoad == true && isPrev != nil {
                            if isPrev == false {
                                await viewModel.loadNextPage()
                                dataDidLoad = true
                            } else if isPrev == true {
                                await viewModel.loadPrevPage()
                                dataDidLoad = true
                            } else {
                                await viewModel.loadGames()
                                dataDidLoad = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    HomeView()
}
