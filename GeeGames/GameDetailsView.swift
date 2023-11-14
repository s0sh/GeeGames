//
//  GameDetailsView.swift
//  GeeGames
//
//  Created by Roman Bigun on 14.11.2023.
//

import SwiftUI

struct Settings {
    static let shadowRadius = 2.0
}

struct GameDetailsView: View {
    
    @State var game: Game
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                HStack {
                    Text(" \(game.name)")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: Settings.shadowRadius, x: 2, y: 2)
                        .frame(width: .infinity, alignment: .leading)
                        .padding(.top)
                }
               
                ImageView(urlString: game.backgroundImage)
                
                VStack {
                    HStack {
                        Text("Genre: ")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: Settings.shadowRadius, x: 2, y: 2)
                            .frame(width: .infinity, alignment: .leading)
                        
                        ForEach(game.genres) {
                            Text("\($0.name),")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(width: .infinity, alignment: .leading)
                        }
                    }
                        
                        ForEach(game.platforms) {
                            if let req = $0.requirementsEn {
                                Text("Minimum requirements for: \($0.platform.name)")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                    .shadow(color: .black, radius: Settings.shadowRadius, x: 1, y: 1)
                                    .padding(20)
                                TestHTMLText(html: req.minimum)
                            }
                        }
                    
                    Text("Supported platforms: ").fontWeight(.bold)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(game.platforms) {
                                Text("\($0.platform.name),")
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundColor(.black)
                                    .shadow(color: .black, radius: Settings.shadowRadius, x: 1, y: 1)
                                    .frame(width: .infinity, alignment: .leading)
                            }
                        }
                    }

                }
                
            }.background(SwiftUI.Color.white)  
        }
    }
}

struct TestHTMLText: View {
    
    @State var html = ""
    
    var body: some View {
        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), 
                                                            options: [.documentType: NSAttributedString.DocumentType.html],
                                                            documentAttributes: nil),
           var attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
            
            Text(attributedString)
             .background(SwiftUI.Color.white)
        } else {
            // fallback...
            Text(html)
        }
    }
}

//#Preview {
//    GameDetailsView()
//}
