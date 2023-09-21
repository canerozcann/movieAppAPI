//
//  canerDeneme3App.swift
//  canerDeneme3
//
//  Created by Caner Özcan on 28.08.2023.
//

import SwiftUI

@main
struct movieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
