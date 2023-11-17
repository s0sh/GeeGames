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
   
    var body: some View {
        List {
            ForEach(favorites) { fav in
                    ZStack {
                        Image(uiImage: UIImage(data: fav.image!)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 350)
                        
                            .listRowSeparator(.hidden)
                        Text("\(fav.name!)")
                            .font(.system(size: 22, weight: .black))
                            .foregroundColor(.red)
                            .shadow(color: .red, radius: 5).listRowSeparator(.hidden)
                    }.frame(maxWidth: .infinity)
                }
            }
    }
}

#Preview {
    FavoriteView()
}
