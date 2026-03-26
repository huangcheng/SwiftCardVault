# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CardVault ("The Vault") is a **SwiftUI + SwiftData** multiplatform app (iOS 18+ / macOS 15+) for credit card management. Currently at early scaffold stage (Xcode template). The full product spec is in `CreditCardManager_PRD.md` and AI assistant guidelines are in `AGENTS.md`.

## Build & Run

Open `CardVault.xcodeproj` in **Xcode 16+**. No external dependencies or package managers.

- **iOS**: Select iPhone simulator/device → Cmd+R
- **macOS**: Select "My Mac" → Cmd+R
- **Unit tests**: Cmd+U (uses Swift Testing framework, not XCTest)
- **CLI build**: `xcodebuild -project CardVault.xcodeproj -scheme CardVault -destination 'platform=iOS Simulator,name=iPhone 16'`
- **CLI test**: `xcodebuild test -project CardVault.xcodeproj -scheme CardVault -destination 'platform=iOS Simulator,name=iPhone 16'`

## Architecture

The app is being built toward a three-tab structure: **Vault** (dashboard), **Manage** (card CRUD), **Profile** (stats/settings).

### Target directory layout (under `CardVault/`)

```
App/              → App entry point, global state
Features/
  Vault/          → Dashboard tab (card stack, security radar, vault integrity)
  Manage/         → Card CRUD (add/edit/delete, OCR scan)
  Profile/        → Stats, charts, settings, security toggles
Core/
  Models/         → SwiftData models (CreditCard, SecurityEvent, SpendingCategory)
  Services/       → Keychain, biometrics, notifications, CloudKit, export/import, OCR
  Utilities/      → Luhn validation, card network detection, crypto, clipboard
Resources/        → Assets.xcassets, Localizable.xcstrings
```

### Data architecture (two-tier storage)

- **SwiftData**: Card metadata (nicknames, dates, limits, balances). Syncs via CloudKit Private DB.
- **Keychain Services**: Card numbers and CVVs only (`kSecAttrAccessibleWhenUnlockedThisDeviceOnly`). Never log/print these values.

### Platform adaptation

Single codebase. Use `#if os(iOS)` / `#if os(macOS)` only when behavior must diverge:
- iOS: `TabView` navigation
- macOS: `NavigationSplitView` with sidebar

Push platform-specific code as far down the view hierarchy as possible.

## Key Technical Constraints

- **No third-party dependencies** — pure first-party Apple frameworks only
- **No network calls** — zero telemetry/analytics; only outbound is CloudKit sync
- **Biometric auth is mandatory** — Face ID / Touch ID via `LAContext`, cannot be disabled
- **All `@Model` properties must have default values** — required for CloudKit compatibility
- **Cross-platform export**: `.vault` file format (AES-256-GCM + Argon2id KDF), compatible with companion Qt version
- **i18n**: English (en) + Simplified Chinese (zh-Hans) via Xcode String Catalog (`.xcstrings`). All user-facing strings must use `String(localized:)` or `LocalizedStringKey`

## Coding Conventions

- **SwiftUI-first** — no UIKit/AppKit unless SwiftUI lacks the capability
- **Async/await** with structured concurrency — no completion handlers
- **`@Observable`** for view models, **`@Environment`** for shared services
- **Accessibility**: every interactive element needs `accessibilityLabel` + `accessibilityHint`; respect `accessibilityReduceMotion`
- **Sensitive data**: never log/print/store card numbers or CVVs outside Keychain; use `Data`/`ContiguousBytes` and zero memory after use

## Design System: "Liquid Glass & Secure Depth"

- **No-Line Rule**: no 1px borders — use background color shifts and `.glassEffect()` materials
- Dark base: `#131313` (never pure black)
- Primary: `#aac7ff` (dark) / `#0058bc` (light)
- Fonts: Manrope (headlines/numbers), Plus Jakarta Sans (body/labels), SF Mono (card numbers)
- Card overlap: -160px vertical offset
- Touch animation: `.spring(response: 0.4, dampingFraction: 0.7)` translate up 20px
- Corner radius: `RoundedRectangle(cornerRadius: 24)` for cards
- Buttons: `.clipShape(Capsule())` for primary CTAs

## Stitch Design Reference

Design comps in Stitch project `16203673754999454503`. See PRD Section 16 for screen IDs.
