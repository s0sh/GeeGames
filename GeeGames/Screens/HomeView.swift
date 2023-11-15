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
    
    var body: some View {
        
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
                    List {
                        ForEach(viewModel.gamesInfo) { item in
                            VStack(alignment: .center, spacing: 20) {
                                
                                Spacer()
                                
                                Text("\(item.name)")
                                    .font(.system(size: 18, weight: .semibold))
                                    .shadow(color: .gray, radius: 5).listRowSeparator(.hidden)
                                
                                NavigationLink {
                                    GameDetailsView(game: item)
                                } label: {
                                    ImageView(urlString: item.backgroundImage)
                                }
                                
                                RatingView(rating: Int(item.rating)).listRowSeparator(.hidden)
                                
                                Spacer()
                                
                            }.listRowSeparator(.hidden)
                            //.border(SwiftUI.Color.gray).cornerRadius(3.0)
                                .background(SwiftUI.Color.white)
                            
                        }
                    }.listRowBackground(SwiftUI.Color.clear)
                    
                }.navigationTitle("Top Games [\(viewModel.data.count)]")
                    .task {
                       // if dataDidLoad == false {
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
                       // }
                    }
            }
        }
    }
}

#Preview {
    HomeView()
}
