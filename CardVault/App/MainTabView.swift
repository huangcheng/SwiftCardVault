//
//  MainTabView.swift
//  CardVault
//

import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        #if os(iOS)
        iOSTabView
        #else
        macOSSidebarView
        #endif
    }

    // MARK: - iOS Tab View

    @ViewBuilder
    private var iOSTabView: some View {
        @Bindable var state = appState
        TabView(selection: $state.selectedTab) {
            VaultView()
                .tabItem {
                    Label(Tab.vault.label, systemImage: Tab.vault.sfSymbol)
                }
                .tag(Tab.vault)

            ManagePlaceholderView()
                .tabItem {
                    Label(Tab.manage.label, systemImage: Tab.manage.sfSymbol)
                }
                .tag(Tab.manage)

            ProfilePlaceholderView()
                .tabItem {
                    Label(Tab.profile.label, systemImage: Tab.profile.sfSymbol)
                }
                .tag(Tab.profile)
        }
        .tint(Color.primaryToken)
    }

    // MARK: - macOS Sidebar View

    #if os(macOS)
    @ViewBuilder
    private var macOSSidebarView: some View {
        @Bindable var state = appState
        NavigationSplitView {
            List(selection: $state.selectedTab) {
                Section {
                    ForEach(Tab.allCases) { tab in
                        Label(tab.label, systemImage: tab.sfSymbol)
                            .tag(tab)
                    }
                } header: {
                    HStack(spacing: 8) {
                        Image(systemName: "lock.shield.fill")
                            .foregroundStyle(Color.primaryToken)
                        Text("CardVault")
                            .font(.headlineSM)
                    }
                    .padding(.bottom, 8)
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 220)
        } detail: {
            switch appState.selectedTab {
            case .vault:
                VaultView()
            case .manage:
                ManagePlaceholderView()
            case .profile:
                ProfilePlaceholderView()
            }
        }
    }
    #endif
}

#Preview {
    MainTabView()
        .environment(AppState(previewMode: true))
}
