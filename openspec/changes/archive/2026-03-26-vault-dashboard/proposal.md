## Why

The Vault tab currently shows a placeholder view. This is the app's primary screen — the first thing users see after biometric unlock. The Stitch design comps define a rich dashboard with total wealth metrics, an overlapping card stack, security radar, and platform-adaptive layouts (iOS TabView vs macOS sidebar with expanded dashboard panels). Implementing this screen establishes the visual identity and core interaction patterns for the entire app.

## What Changes

- Replace `VaultPlaceholderView` with the full Vault dashboard implementation
- **iOS (Mobile)**: Header with lock icon + "The Vault" + settings gear, total wealth metric ($42,890.12 format) with growth badge, stacked credit card display with -160px overlap and spring animations, security radar event list, bottom tab navigation (already in place)
- **macOS (Desktop)**: Expanded layout with total secured value, multi-column active card display, vault integrity score panel (96/100), vault stream (transaction log), quick controls (Lock All, History, Audit, Link), and vault composition breakdown
- Create reusable sub-components: `TotalWealthCard`, `CardStackView`, `CardStackItem`, `SecurityRadarView`, `VaultIntegrityView` (macOS), `VaultStreamView` (macOS), `QuickControlsView` (macOS)
- Support both dark and light mode via Aether Glass design tokens (automatic via Asset Catalog)
- All text localized for en + zh-Hans

## Capabilities

### New Capabilities
- `vault-dashboard-ios`: iOS mobile Vault dashboard with total wealth metric, stacked card display with touch animations, and security radar
- `vault-dashboard-macos`: macOS desktop Vault dashboard with expanded panels including vault integrity score, vault stream transaction log, quick controls, and vault composition

### Modified Capabilities

## Impact

- **Features/Vault/**: Replace `VaultPlaceholderView.swift` with 7-8 new view files
- **Localization**: Add ~30 new strings to `Localizable.xcstrings` for vault dashboard labels
- **No model changes**: Uses existing `CreditCard`, `SecurityEvent` SwiftData models
- **No service changes**: Reads from SwiftData via `@Query`
