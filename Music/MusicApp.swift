//
//  MusicApp.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI

@main
struct MusicApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
