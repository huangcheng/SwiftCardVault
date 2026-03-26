# AGENTS.md

This file provides guidance to AI coding assistants (Claude Code, GitHub Copilot, Cursor, etc.) when working with code in this repository.

## Project Overview

CardVault ("The Vault") is a multiplatform Apple app for credit card management built with **SwiftUI** and **SwiftData**. It targets iOS 18+ and macOS 15+ from a single codebase. The full product spec lives in `CreditCardManager_PRD.md`.

A companion Qt-based version for Windows and Linux exists at `QCardVault`.

The project is currently in early scaffold stage — only the default Xcode multiplatform template exists. The PRD describes the full target architecture.

## Build & Run

Open `CardVault.xcodeproj` in Xcode 16+.

- **iOS:** Select an iPhone simulator or device, then Cmd+R.
- **macOS:** Select "My Mac" as the destination, then Cmd+R.
- **Tests:** Cmd+U to run unit and UI tests.

No external dependencies or package managers required — the app uses only first-party Apple frameworks.

## Target Architecture (from PRD)

The app has three main tabs: **Vault** (dashboard), **Manage** (card CRUD), **Profile** (stats/settings).

Planned directory layout under `CardVault/`:

```
CardVault/
├── App/                          # App entry point, global state
├── Features/
│   ├── Vault/                    # Dashboard tab views
│   ├── Manage/                   # Card CRUD tab views
│   └── Profile/                  # Stats & settings tab views
├── Core/
│   ├── Models/                   # SwiftData models (CreditCard, SecurityEvent, SpendingCategory)
│   ├── Services/                 # Keychain, biometrics, notifications, CloudKit, export/import, OCR
│   └── Utilities/                # Luhn validation, card network detection, crypto helpers, clipboard
└── Resources/                    # Assets.xcassets, Localizable.xcstrings
```

## Key Technical Decisions

- **Data persistence**: SwiftData for card metadata; Keychain Services for card numbers and CVVs (`kSecAttrAccessibleWhenUnlockedThisDeviceOnly`)
- **Cloud sync**: CloudKit Private Database via SwiftData's built-in sync — metadata only. Keychain secrets sync via iCloud Keychain (user-controlled system setting)
- **Biometrics**: Face ID / Touch ID via `LAContext` — mandatory, not optional
- **Cross-platform export**: Encrypted `.vault` file (AES-256-GCM, Argon2id KDF) compatible with the Qt version for Windows/Linux
- **Card scanning**: Vision framework (`VNRecognizeTextRequest`) for OCR
- **Charts**: Swift Charts for all data visualizations
- **No third-party dependencies**: Pure first-party Apple frameworks only
- **No network calls**: Zero telemetry, no analytics. Only outbound connection is CloudKit sync
- **i18n**: All strings wrapped in `String(localized:)` / `LocalizedStringKey`. Two languages: English (en) and Simplified Chinese (zh-Hans) via Xcode String Catalog (`.xcstrings`)

## Platform-Adaptive Patterns

This is a multiplatform app. Use `#if os(iOS)` / `#if os(macOS)` only when platform behavior must diverge:

```swift
// Navigation: TabView on iOS, NavigationSplitView on macOS
#if os(iOS)
TabView { ... }
#elseif os(macOS)
NavigationSplitView { ... }
#endif
```

Most views, models, and services should be fully shared. Push platform-specific code as far down the view hierarchy as possible.

## Design System: "Liquid Glass & Secure Depth"

- **No-Line Rule**: No 1px borders. Boundaries via background color shifts and Liquid Glass materials.
- Dark base color: `#131313` (never pure black)
- Primary: `#aac7ff` (dark) / `#0058bc` (light)
- Fonts: Manrope (headlines/numbers), Plus Jakarta Sans (body/labels), SF Mono for card numbers
- Card overlap: -160px vertical for wallet depth effect
- Touch animation: `.spring(response: 0.4, dampingFraction: 0.7)` translate upward 20px
- Glass-morphism: `.glassEffect()` modifier for frosted panels
- SF Symbols 7: Variable Color and Animate features for security indicators

## Coding Conventions

- **SwiftUI-first**: No UIKit/AppKit unless absolutely necessary for functionality not available in SwiftUI.
- **Default values on @Model**: All SwiftData model properties must have default values for CloudKit compatibility.
- **Async/await**: Use structured concurrency. No completion handlers.
- **Observation**: Use `@Observable` for view models, `@Environment` for shared services.
- **Accessibility**: Every interactive element needs `accessibilityLabel` and `accessibilityHint`. Respect `accessibilityReduceMotion`.
- **Localization**: Never hardcode user-facing strings. Always use `String(localized:)` or `LocalizedStringKey`.
- **Sensitive data**: Never log, print, or store card numbers or CVVs outside the Keychain. Use `Data` / `ContiguousBytes` and zero memory after use.

## Stitch Design Reference

Design comps are in Stitch project `16203673754999454503`. See PRD Section 16 for screen IDs covering all tabs in mobile/desktop, light/dark variants.
