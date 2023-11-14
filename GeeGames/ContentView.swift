//
//  ContentView.swift
//  GeeGames
//
//  Created by Roman Bigun on 13.11.2023.
//

import SwiftUI

let gamesListUrl = URL(string: "https://api.rawg.io/api/games?key=a716c6cb697f47dfa96b5013504dc76c")!

struct HomeView: View {
    
    @State var showSheetPresented = false
    
    @State private var gamesInfo: [Game] = []
    
    @StateObject private var viewModel = GamesListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.gamesInfo) { item in
                        VStack {
                            ImageView(urlString: item.backgroundImage).onTapGesture {
                                showSheetPresented.toggle()
                            }.sheet(isPresented: $showSheetPresented, content: {
                                GameDetailsView(game: item)
                             })
                            
                            Text("\(item.name)")
                            Text("Rating: \(item.rating) of \(item.ratingTop)")
                        }
                    }
                }
            }.navigationTitle("Top Games")
            .task {
                await viewModel.loadGames()
            }
        }
    }
}

#Preview {
    HomeView()
}
