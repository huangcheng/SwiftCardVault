//
//  AppState.swift
//  CardVault
//

import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
    case vault
    case manage
    case profile

    var id: String { rawValue }

    var label: String {
        switch self {
        case .vault: String(localized: "Vault")
        case .manage: String(localized: "Manage")
        case .profile: String(localized: "Profile")
        }
    }

    var sfSymbol: String {
        switch self {
        case .vault: "wallet.bifold"
        case .manage: "creditcard"
        case .profile: "person.crop.circle"
        }
    }
}

@Observable
final class AppState {
    var isAuthenticated: Bool = false
    var isLocked: Bool = true
    var selectedTab: Tab = .vault

    // Preferences
    var autoLockTimeout: TimeInterval = 30
    var hideSensitiveData: Bool = true
    var clipboardAutoClear: Bool = true
    var iCloudSyncEnabled: Bool = true

    #if DEBUG
    var previewMode: Bool = false

    init(previewMode: Bool = false) {
        self.previewMode = previewMode
        if previewMode {
            self.isAuthenticated = true
            self.isLocked = false
        }
    }
    #else
    init() {}
    #endif

    func unlock() {
        isAuthenticated = true
        isLocked = false
    }

    func lock() {
        isAuthenticated = false
        isLocked = true
    }
}
