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
        if favorites.count == 0 {
            Text("It is nothing here!!!")
                .font(.system(size: 22, weight: .black))
                .foregroundColor(.red)
        } else {
            List {
                ForEach(favorites) { fav in
                    Section {
                        VStack {
                            Image(uiImage: UIImage(data: fav.image!)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxHeight: 350)
                                .listRowSeparator(.hidden)
                            
                            Text("\(fav.name!)")
                                .font(.system(size: 22, weight: .black))
                                .foregroundColor(.black)
                                .shadow(color: .black, radius: 5).listRowSeparator(.hidden)
                            Button {
                                message = "\(fav.name!): Removed!"
                                try? moc.delete(fav)
                                try? moc.save()
                            } label: {
                                Text("Remove from Favorites X")
                                    .frame(width: 300, height: 30)
                                    .font(.system(size: 22, weight: .black))
                                    .foregroundColor(.red)
                                    .shadow(color: .red, radius: 10)
                            }
                        }.frame(maxWidth: .infinity)
                    }
                }
            }.navigationTitle("")
                .messageView(text: $message)
        }
    }
}

#Preview {
    FavoriteView()
}
