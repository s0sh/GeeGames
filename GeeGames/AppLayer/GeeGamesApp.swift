//
//  GeeGamesApp.swift
//  GeeGames
//
//  Created by Roman Bigun on 13.11.2023.
//

import SwiftUI

@main
struct GeeGamesApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                MenuView()
            }
        }
    }
}
