## 1. Project Structure & Cleanup

- [x] 1.1 Create directory structure: `App/`, `Features/Vault/`, `Features/Manage/`, `Features/Profile/`, `Core/Models/`, `Core/Services/`, `Core/Utilities/`, `Resources/` under `CardVault/`
- [x] 1.2 Remove template files: `Item.swift`, `ContentView.swift`
- [x] 1.3 Set up Asset Catalog with dark/light color sets for all design tokens (surface, primaryToken, secondaryToken, etc.)

## 2. Core Data Models

- [x] 2.1 Create `CardNetwork` enum (visa, mastercard, amex, unionpay, jcb, discover) with `displayName`, `sfSymbolName`, Codable/CaseIterable conformance
- [x] 2.2 Create `SecurityEventType` enum and `RiskLevel` enum with Codable conformance and Comparable for RiskLevel
- [x] 2.3 Create `CreditCard` SwiftData `@Model` with all metadata properties and CloudKit-compatible defaults
- [x] 2.4 Create `SecurityEvent` SwiftData `@Model` with all properties and defaults
- [x] 2.5 Create `SpendingCategory` SwiftData `@Model` with all properties and defaults

## 3. Core Services

- [x] 3.1 Implement `KeychainService` with save/get/delete methods for card numbers and CVVs using Security framework direct API
- [x] 3.2 Implement `BiometricService` with `authenticate()` async method using `LAContext.evaluatePolicy(.deviceOwnerAuthentication)` and `biometricType()` availability check

## 4. Core Utilities

- [x] 4.1 Implement `LuhnValidator` with `isValid(_ cardNumber: String) -> Bool` handling spaces, dashes, non-numeric, and empty input
- [x] 4.2 Implement `CardNetworkDetector` with `detect(_ cardNumber: String) -> CardNetwork?` supporting all 6 networks via BIN pattern matching
- [x] 4.3 Implement `ClipboardManager` with `copyWithAutoClear(_ text: String, clearAfter: TimeInterval)` using Task-based timer and cancellation

## 5. Design System

- [x] 5.1 Create `Color` extensions for all dark/light mode tokens (surface hierarchy, primary, secondary, tertiary, error, on-surface variants)
- [x] 5.2 Create `Font` extensions for typography scale (displayLG, headlineSM, titleMD, bodyMD, labelSM, cardNumber) with system font fallbacks
- [x] 5.3 Create `LiquidGlassModifier` view modifier with `.glassEffect()` and pre-iOS 26 fallback to `.ultraThinMaterial`
- [x] 5.4 Create `CardShapeModifier` (cornerRadius: 24, no borders), `PrimaryButtonStyle` (capsule, scale animation), and animation constants

## 6. App Shell & Navigation

- [x] 6.1 Create `AppState` @Observable class with isAuthenticated, isLocked, selectedTab, preferences (autoLockTimeout, hideSensitiveData, clipboardAutoClear, iCloudSyncEnabled), and previewMode
- [x] 6.2 Create `LockScreenView` with app icon, "The Vault" title, unlock button triggering BiometricService
- [x] 6.3 Create `MainTabView` with platform-adaptive navigation: TabView (iOS) / NavigationSplitView (macOS) with 3 sections
- [x] 6.4 Create placeholder views for Vault, Manage, and Profile tabs
- [x] 6.5 Restructure `CardVaultApp.swift` with ModelContainer (CreditCard, SecurityEvent, SpendingCategory), AppState injection, and auth gate → main navigation flow
- [x] 6.6 Implement auto-lock on background using `@Environment(\.scenePhase)` to reset `isAuthenticated`

## 7. Localization

- [x] 7.1 Create `Localizable.xcstrings` String Catalog with all foundation-layer strings in en and zh-Hans (tab names, auth screen, button labels, security messages)

## 8. Unit Tests

- [x] 8.1 Write Swift Testing tests for `LuhnValidator` covering valid, invalid, non-numeric, and empty inputs
- [x] 8.2 Write Swift Testing tests for `CardNetworkDetector` covering all 6 networks, unknown patterns, and partial input
- [x] 8.3 Write Swift Testing tests for `RiskLevel` Comparable conformance
- [x] 8.4 Write Swift Testing tests for `CreditCard` model default values and initialization
