//
//  GeeGamesApp.swift
//  GeeGames
//
//  Created by Roman Bigun on 13.11.2023.
//

import SwiftUI

@main
struct GeeGamesApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                    .environment(\.managedObjectContext, dataController.conteiner.viewContext)
            }
        }
    }
}
