//
//  ClipboardManager.swift
//  CardVault
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

@MainActor
final class ClipboardManager {

    static let shared = ClipboardManager()

    private var clearTask: Task<Void, Never>?

    private init() {}

    func copyWithAutoClear(_ text: String, clearAfter: TimeInterval = 30) {
        // Cancel any existing clear timer
        clearTask?.cancel()

        // Copy to clipboard
        #if os(iOS)
        UIPasteboard.general.string = text
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
        #endif

        // Schedule auto-clear
        clearTask = Task {
            try? await Task.sleep(for: .seconds(clearAfter))
            guard !Task.isCancelled else { return }
            clearClipboard()
        }
    }

    private func clearClipboard() {
        #if os(iOS)
        UIPasteboard.general.string = ""
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        #endif
    }
}
