//
//  CardVaultApp.swift
//  CardVault
//
//  Created by Cheng Huang on 2026-03-26.
//

import SwiftUI
import SwiftData

@main
struct CardVaultApp: App {
    @State private var appState = AppState()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CreditCard.self,
            SecurityEvent.self,
            SpendingCategory.self,
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            Group {
                if appState.isAuthenticated {
                    MainTabView()
                } else {
                    LockScreenView()
                }
            }
            .environment(appState)
            .onAppear {
                SampleData.seedIfNeeded(modelContext: sharedModelContainer.mainContext)
            }
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .background {
                    appState.lock()
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }

    @Environment(\.scenePhase) private var scenePhase
}
