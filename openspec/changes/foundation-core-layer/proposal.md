## Why

CardVault is currently an empty Xcode template with no business logic, data models, or services. Before building any feature UI (Vault, Manage, Profile tabs), we need the architectural foundation: SwiftData models, Keychain-based secret storage, biometric authentication, design system tokens, utility functions, and the app shell with tab/sidebar navigation. This foundation enables all future feature work to build on a solid, tested core.

## What Changes

- Replace the placeholder `Item` model with production SwiftData models: `CreditCard`, `SecurityEvent`, `SpendingCategory`, and supporting enums (`CardNetwork`, `SecurityEventType`, `RiskLevel`)
- Implement `KeychainService` for secure storage of card numbers and CVVs with `kSecAttrAccessibleWhenUnlockedThisDeviceOnly`
- Implement `BiometricService` wrapping `LAContext` for mandatory Face ID / Touch ID authentication
- Implement `ClipboardManager` with auto-clear after 30 seconds
- Implement `LuhnValidator` for card number validation
- Implement `CardNetworkDetector` for BIN-based network auto-detection (Visa, Mastercard, Amex, UnionPay, JCB, Discover)
- Create design system color tokens, typography definitions, and reusable view modifiers for the "Liquid Glass & Secure Depth" design language
- Restructure `CardVaultApp.swift` with proper `ModelContainer` configuration for all models
- Create `AppState` observable for global state (authentication status, lock state, settings)
- Build platform-adaptive app shell: `TabView` on iOS, `NavigationSplitView` with sidebar on macOS
- Add placeholder views for each tab (Vault, Manage, Profile) as future extension points
- Set up `Localizable.xcstrings` with initial string catalog entries for both `en` and `zh-Hans`

## Capabilities

### New Capabilities
- `data-models`: SwiftData model definitions for CreditCard, SecurityEvent, SpendingCategory with CloudKit-compatible defaults and supporting enums
- `keychain-service`: Secure Keychain CRUD operations for card numbers and CVVs
- `biometric-auth`: Mandatory Face ID / Touch ID authentication via LAContext with passcode fallback
- `card-utilities`: Luhn validation, BIN-based card network detection, and clipboard auto-clear
- `design-system`: Color tokens, typography scale, Liquid Glass view modifiers, and reusable component styles
- `app-shell`: Platform-adaptive navigation (TabView / NavigationSplitView), app entry point, global state management

### Modified Capabilities

## Impact

- **Code**: Complete replacement of template code (`Item.swift`, `ContentView.swift`, `CardVaultApp.swift`) with production architecture under `App/`, `Core/Models/`, `Core/Services/`, `Core/Utilities/`, and `Resources/`
- **Xcode project**: New file groups and directory structure; ModelContainer schema updated to production models
- **Dependencies**: None (pure first-party Apple frameworks: SwiftUI, SwiftData, LocalAuthentication, Security, CryptoKit)
- **Testing**: Unit tests for validators, network detection, and Keychain service using Swift Testing framework
