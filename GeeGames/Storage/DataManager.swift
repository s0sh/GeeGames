//
//  DataManager.swift
//  GeeGames
//
//  Created by Roman Bigun on 16.11.2023.
//

import Foundation
import SwiftUI
import CoreData

struct DataManager {
    
    let moc: NSManagedObjectContext
    let favorites: FetchedResults<Favorites>
    
    init(moc: NSManagedObjectContext, favorites: FetchedResults<Favorites>) {
        self.moc = moc
        self.favorites = favorites
    }
    
    func add(imageData: Data, id: Int, name: String) {
        var favorite = Favorites(context: moc)
        favorite.image = imageData
        favorite.id = Int16(id)
        favorite.name = name

        try? moc.save()
    }
    
}
