//
//  A2_iOS_Patrick_101205106App.swift
//  A2_iOS_Patrick_101205106
//
//  Created by Patrick Millares on 2026-04-09.
//

import SwiftUI
import CoreData

@main
struct A2_iOS_Patrick_101205106App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
