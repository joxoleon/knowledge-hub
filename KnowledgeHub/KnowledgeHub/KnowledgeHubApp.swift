//
//  KnowledgeHubApp.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI
import SwiftData

@main
struct KnowledgeHubApp: App {
    @StateObject private var themeManager = ThemeManager(defaultTheme: .midnightBlue)

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
