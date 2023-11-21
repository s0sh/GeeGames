//
//  GeeGamesApp.swift
//  GeeGames
//
//  Created by Roman Bigun on 13.11.2023.
//

import SwiftUI

@main
struct GeeGamesApp: App {
    let appStore = AppStore(initialState: .init(),
                         reducer: appReducer,
                         environment: World())
    
    @StateObject private var dataController = DataController()
    @StateObject private var viewModel = GamesListViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                if UserDefaults.standard.bool(forKey: "tearms_tapped") == true {
                    //HomeContainerView().environmentObject(appStore)
                    HomeView(onCommit: nil).environmentObject(viewModel)
                    MenuView().environment(\.managedObjectContext, dataController.conteiner.viewContext)
                        .environmentObject(viewModel)
                } else {
                    StartScreen().environmentObject(appStore)
                }
            }
        }
    }
}
