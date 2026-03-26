## Context

CardVault is a multiplatform SwiftUI app (iOS 18+ / macOS 15+) currently at Xcode template stage. The PRD defines a comprehensive credit card manager with a two-tier storage model (SwiftData for metadata, Keychain for secrets), mandatory biometric auth, and a "Liquid Glass" design system. This change establishes the architectural foundation before any feature UI is built.

Current state: 3 files — a placeholder `Item` model, a template `ContentView`, and the app entry point. No business logic exists.

Constraints:
- No third-party dependencies (pure Apple frameworks)
- All `@Model` properties must have defaults (CloudKit compatibility)
- Sensitive data (card numbers, CVVs) must never leave Keychain
- Biometric auth is mandatory and cannot be disabled
- Must support iOS 18+ and macOS 15+ from a single codebase

## Goals / Non-Goals

**Goals:**
- Define production SwiftData models with CloudKit-compatible defaults
- Implement secure Keychain CRUD for card secrets
- Implement mandatory biometric authentication gate
- Create reusable design system tokens and view modifiers
- Build platform-adaptive app shell (TabView / NavigationSplitView)
- Establish utility layer (Luhn validation, card network detection, clipboard management)
- Set up localization infrastructure for en + zh-Hans
- Write unit tests for all testable utilities and services

**Non-Goals:**
- Feature UI (Vault dashboard, card list, add card flow, profile stats) — separate changes
- CloudKit sync configuration beyond SwiftData defaults
- OCR card scanning (Vision framework)
- Export/import `.vault` file format
- Notification scheduling
- Security event monitoring service
- Financial health score calculation
- Swift Charts visualizations

## Decisions

### 1. Directory Structure: Feature-Based Organization

Adopt the structure from the PRD: `App/`, `Features/`, `Core/Models/`, `Core/Services/`, `Core/Utilities/`, `Resources/`.

**Why**: Clear separation of concerns. Features are isolated. Core layer is reusable. Matches the PRD so future contributors can map docs to code instantly.

**Alternative considered**: Flat structure with all files at root — rejected because the app will grow to 40+ files across 3 feature tabs.

### 2. Keychain Service: Security Framework Direct API

Use `Security.framework` directly (`SecItemAdd`, `SecItemCopyMatching`, `SecItemUpdate`, `SecItemDelete`) rather than any wrapper pattern.

**Why**: No third-party deps allowed. The Security framework API is stable and well-documented. Keys follow `card_number_\(cardId)` and `card_cvv_\(cardId)` convention from PRD.

**Alternative considered**: Actor-based KeychainActor — unnecessary complexity for synchronous Keychain calls. Keep it as a simple struct with static-like methods.

### 3. Biometric Service: LAContext with Device Passcode Fallback

Use `LAContext.evaluatePolicy(.deviceOwnerAuthentication)` which combines biometric + device passcode fallback automatically.

**Why**: The PRD specifies biometric is mandatory with passcode fallback after 3 failed attempts. `.deviceOwnerAuthentication` (not `.deviceOwnerAuthenticationWithBiometrics`) handles this natively — the system manages retry counting and passcode fallback.

### 4. AppState: @Observable Class

Global app state as an `@Observable` class injected via `.environment()`. Tracks: `isAuthenticated`, `isLocked`, user preferences (auto-lock timeout, hide sensitive data, clipboard auto-clear).

**Why**: `@Observable` is the modern observation pattern for iOS 18+. Simpler than `ObservableObject` + `@Published`. Injected via environment so any view can access it.

**Alternative considered**: Multiple separate environment values — rejected because auth state, lock state, and preferences are tightly coupled.

### 5. Design System: Extension-Based Tokens

Color tokens as `Color` extensions (`Color.surface`, `Color.surfaceContainerLow`, etc.). Typography as `Font` extensions. Reusable modifiers as `ViewModifier` implementations (`LiquidGlassModifier`, `CardShapeModifier`).

**Why**: Swift-native approach. Color extensions work with SwiftUI's built-in dark/light mode switching via asset catalogs. View modifiers compose naturally.

**Alternative considered**: Theme object with all tokens — heavier, and SwiftUI already has the environment-based theming pattern via color scheme.

### 6. Platform Adaptation: Minimal #if os() Usage

Platform-specific code only in `ContentView` (now `MainTabView`) for navigation structure. All other views are platform-agnostic.

**Why**: PRD says push platform-specific code as far down as possible. The only true divergence is TabView vs NavigationSplitView.

## Risks / Trade-offs

- **[Risk] Keychain not available in Simulator previews** → Mitigation: KeychainService uses a protocol so tests can use a mock. In previews, use sample data without Keychain calls.
- **[Risk] Biometric auth blocks SwiftUI previews** → Mitigation: AppState has a `previewMode` flag that bypasses auth in `#if DEBUG` preview contexts.
- **[Risk] CloudKit schema changes are irreversible in production** → Mitigation: All `@Model` properties have defaults. No optional-to-required migrations. This change only defines models; CloudKit container is configured later.
- **[Risk] Argon2id not in CryptoKit** → Mitigation: Out of scope for this change. Export/import is a future change that will address KDF selection.
- **[Trade-off] Custom fonts (Manrope, Plus Jakarta Sans) require bundling** → Design system will define the font scale but use system fonts as fallback. Actual font files can be added in a follow-up if the team decides to bundle them, or we use `Font.custom()` with registration.
