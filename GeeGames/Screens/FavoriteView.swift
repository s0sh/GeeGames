//
//  FavoriteView.swift
//  GeeGames
//
//  Created by Roman Bigun on 16.11.2023.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) private var favorites: FetchedResults<Favorites>
    
    @State var message: String = ""
    
    var body: some View {
        
        NavigationView {
            
            if favorites.count == 0 {
                Text("It is nothing here!!!")
                    .font(.system(size: 22, weight: .black))
                    .foregroundColor(.blue)
                    .shadow(color: .blue, radius: 8)
            } else {
                
                List {
                    ForEach(favorites) { fav in
                        NavigationLink {
                            GameDetailsView(isGenre: true, isFavorites: true, gameId: Int(fav.id))
                                .navigationBarHidden(false)
                        } label: {
                            VStack {
                                Image(uiImage: UIImage(data: fav.image!)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxHeight: 350)
                                    .listRowSeparator(.hidden)
                                
                                Text("\(fav.name!)")
                                    .font(.system(size: 22, weight: .black))
                                    .foregroundColor(.white)
                                    .shadow(color: .white, radius: 5).listRowSeparator(.hidden)
                                
                            }.frame(maxWidth: .infinity)
                        }
                        
                        Button {
                            message = "\(fav.name!): Removed!"
                            try? moc.delete(fav)
                            try? moc.save()
                        } label: {
                            Text("Remove from Favorites X")
                                .background(SwiftUI.Color.clear)
                                .frame(width: 300, height: 30)
                                .font(.system(size: 22, weight: .black))
                                .foregroundColor(.red)
                                .shadow(color: .red, radius: 10)
                            
                        }
                        
                    }.background {
                        SwiftUI.Color("AccentColor")
                            .ignoresSafeArea()
                    }
                }.messageView(text: $message)
            }
        }.tint(.white)
    }
}

#Preview {
    FavoriteView()
}
