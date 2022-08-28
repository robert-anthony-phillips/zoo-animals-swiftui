//
//  zoo_animals_swiftuiApp.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 26/08/2022.
//

import SwiftUI

@main
struct zoo_animals_swiftuiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
