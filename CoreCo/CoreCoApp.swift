//
//  CoreCoApp.swift
//  CoreCo
//
//  Created by roger deutsch on 7/18/23.
//

import SwiftUI

@main
struct CoreCoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
