//
//  DataController.swift
//  GeeGames
//
//  Created by Roman Bigun on 16.11.2023.
//

import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject {
    let conteiner = NSPersistentContainer(name: "GeeGames")
    
    init() {
        conteiner.loadPersistentStores { description, error in
            if let error = error {
                print("Core data load with error: \(error.localizedDescription)")
            }
        }
    }
}
