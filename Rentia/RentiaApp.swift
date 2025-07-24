//
//  RentiaApp.swift
//  Rentia
//
//  Created by DAMII on 23/07/25.
//

import SwiftUI

@main
struct RentiaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
