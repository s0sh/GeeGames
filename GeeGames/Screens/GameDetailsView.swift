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
    
    @State var game: Game?
    
    @StateObject private var viewModel = GamesDetailViewModel()
    
    @State var gamesInfo: GameDetails?
    
    var isGenre = false
    
    var gameId = 0
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) private var favorites: FetchedResults<Favorites>
    @State var dataManager: DataManager?
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            VStack {
                
                if let imageUrl = gamesInfo?.backgroundImage {
                    ImageView(urlString: gamesInfo?.backgroundImage).frame(minHeight: 350)
                }
                
                Text(" \(gamesInfo?.name ?? "")")
                // .frame(maxWidth: .infinity)
                    .font(.system(size: 30, weight: .black, design: .rounded))
                    .foregroundColor(.red)
                    .shadow(color: .red, radius: Settings.shadowRadius)
                
                if isGenre == false {
                    HStack {
                        
                        Spacer(minLength: 10)
                        Text("Genres: ")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .shadow(color: Settings.shadowColor, radius: Settings.shadowRadius, x: 2, y: 2)
                        HStack {
                            ScrollView(.horizontal) {
                                HStack(spacing: 15) {
                                    ForEach(game?.genres ?? []) {
                                        Capsule()
                                            .fill(SwiftUI.Color("AccentColor").opacity(0.8))
                                            .frame(width: 110, height: 30)
                                            .overlay(
                                                Text("\($0.name)")
                                                    .font(.system(size: 15, weight: .semibold))
                                                    .foregroundColor(.white)
                                                    .shadow(color: Settings.shadowColor, radius: Settings.shadowRadius)
                                            )
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                
                if let description = gamesInfo?.description {
                    VStack {
                        Text("Description")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: Settings.shadowRadius, x: 1, y: 1)
                            .padding()
                        
                        TestHTMLText(html: description).offset(x: 5)
                        
                    }
                }
                if isGenre == false {
                    if let platforms = game?.platforms  {
                        ForEach(platforms) {
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
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                
                if let dataManager = self.dataManager {
                    if let url = URL(string: gamesInfo?.backgroundImage ?? "") {
                        try? dataManager.add(imageData: Data(contentsOf: url),
                                             id: gamesInfo?.id ?? 0,
                                             name: gamesInfo?.name ?? "")
                    }
                }
                
            }, label: {
                HStack {
                    Image(systemName: "heart")
                        .frame(width: 30, height: 30)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.red)
                        .alignmentGuide(.bottom) {
                            $0[.top]
                        }
                    
                }
            })
            )
            
        }.offset(y: -30)
            .task {
                viewModel.id = gameId != 0 ? gameId : game!.id
                await viewModel.loadInfo()
                gamesInfo = viewModel.gamesInfo
                dataManager = DataManager(moc: moc, favorites: favorites)
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
