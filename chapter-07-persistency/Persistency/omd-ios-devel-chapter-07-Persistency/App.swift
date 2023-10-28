//
//  omd_ios_devel_chapter_07_PersistencyApp.swift
//  omd-ios-devel-chapter-07-Persistency
//
//  Created by John on 03.11.21.
//

import SwiftUI

@main
struct omd_ios_devel_chapter_07_PersistencyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
