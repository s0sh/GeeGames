//
//  GameDetailsView.swift
//  GeeGames
//
//  Created by Roman Bigun on 14.11.2023.
//

import SwiftUI

struct GameDetailsView: View {
    
    @State var game: Game?
    
    var body: some View {
        Text(game?.name ?? "")
    }
}

#Preview {
    GameDetailsView()
}
