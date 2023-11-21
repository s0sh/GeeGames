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
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                if UserDefaults.standard.bool(forKey: "tearms_tapped") == true {
                    HomeContainerView().environmentObject(appStore)
                    MenuView().environment(\.managedObjectContext, dataController.conteiner.viewContext)
                } else {
                    StartScreen().environmentObject(appStore)
                }
            }
        }
    }
}
