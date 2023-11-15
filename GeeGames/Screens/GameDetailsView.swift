//
//  GameDetailsView.swift
//  GeeGames
//
//  Created by Roman Bigun on 14.11.2023.
//

import SwiftUI

struct Settings {
    static let shadowRadius = 10.0
    static let shadowColor = SwiftUI.Color("AccentColor")
}

struct GameDetailsView: View {
    
    @State var game: Game
    
    @StateObject private var viewModel = GamesDetailViewModel()
    
    @State var gamesInfo: GameDetails?
    
    
    var body: some View {
      
            VStack {
                ScrollView(.vertical) {
                    HStack {
                        Text(" \(game.name)")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.red)
                            .shadow(color: Settings.shadowColor, radius: Settings.shadowRadius, x: 2, y: 2)
                            .padding(.top)
                    }
                    
                    ImageView(urlString: game.backgroundImage)
                    
                    VStack {
                        HStack {
                            Spacer(minLength: 10)
                            Text("Genres: ")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .shadow(color: Settings.shadowColor, radius: Settings.shadowRadius, x: 2, y: 2)
                            
                            HStack {
                                ForEach(game.genres) {
                                    
                                    Capsule()
                                        .fill(SwiftUI.Color.gray.opacity(0.8))
                                        .overlay(
                                            Text("\($0.name)")
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(.white)
                                                .shadow(color: Settings.shadowColor, radius: Settings.shadowRadius)
                                        )
                                }
                                
                            }
                        }
                        
                        if let description = gamesInfo?.description {
                            VStack {
                                Text("Description")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                    .shadow(color: .black, radius: Settings.shadowRadius, x: 1, y: 1)
                                    .padding(20)
                                TestHTMLText(html: description)
                            }
                        }
                        
                        ForEach(game.platforms) {
                            if let req = $0.requirementsEn {
                                Text("Minimum requirements for: \($0.platform.name)")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                    .shadow(color: Settings.shadowColor, radius: Settings.shadowRadius, x: 1, y: 1)
                                    .padding(20)
                                TestHTMLText(html: req.minimum)
                            }
                        }
                    }
                    Spacer()
                }
                /* .background( Image("BG")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 20)
                */
            }.task {
                viewModel.id = game.id
                await viewModel.loadInfo()
                gamesInfo = viewModel.gamesInfo
            }
    }
}

struct TestHTMLText: View {
    
    @State var html = ""
    
    var body: some View {
        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), 
                                                            options: [.documentType: NSAttributedString.DocumentType.html],
                                                            documentAttributes: nil),
           let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
            
            Text(attributedString).background(SwiftUI.Color.white)
        } else {
            // fallback...
            Text(html)
        }
    }
}

//#Preview {
//    GameDetailsView()
//}
