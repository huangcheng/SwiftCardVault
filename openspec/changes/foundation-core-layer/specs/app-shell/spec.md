## ADDED Requirements

### Requirement: Platform-adaptive navigation
The system SHALL provide platform-adaptive navigation: a 3-tab `TabView` on iOS and a `NavigationSplitView` with sidebar on macOS. Both SHALL present the same 3 sections: Vault, Manage, Profile.

#### Scenario: iOS tab navigation
- **WHEN** the app runs on iOS
- **THEN** a `TabView` with 3 tabs SHALL be displayed: Vault (wallet.bifold icon), Manage (creditcard icon), Profile (person.crop.circle icon)

#### Scenario: macOS sidebar navigation
- **WHEN** the app runs on macOS
- **THEN** a `NavigationSplitView` with a sidebar SHALL be displayed containing: CardVault branding, Vault/Manage/Profile navigation items, and an "Add New Card" button at the bottom

### Requirement: ModelContainer configuration
The `CardVaultApp` SHALL configure a `ModelContainer` with schemas for `CreditCard`, `SecurityEvent`, and `SpendingCategory`. The container SHALL be injected into the SwiftUI environment.

#### Scenario: App launch with model container
- **WHEN** the app launches
- **THEN** a `ModelContainer` with all 3 model schemas SHALL be available in the SwiftUI environment

### Requirement: AppState global observable
The system SHALL provide an `AppState` `@Observable` class with properties: `isAuthenticated` (Bool, default false), `isLocked` (Bool, default true), `selectedTab` (Tab enum), `autoLockTimeout` (TimeInterval, default 30), `hideSensitiveData` (Bool, default true), `clipboardAutoClear` (Bool, default true), `iCloudSyncEnabled` (Bool, default true). AppState SHALL be injected via `.environment()`.

#### Scenario: Initial state
- **WHEN** the app launches
- **THEN** `AppState.isAuthenticated` SHALL be `false` and `isLocked` SHALL be `true`

#### Scenario: Post-authentication state
- **WHEN** biometric authentication succeeds
- **THEN** `AppState.isAuthenticated` SHALL be `true` and `isLocked` SHALL be `false`

### Requirement: Authentication gate view
The system SHALL display a lock screen when `AppState.isAuthenticated` is `false`. The lock screen SHALL show the app icon, "The Vault" title, and an "Unlock" button that triggers biometric authentication.

#### Scenario: Locked state display
- **WHEN** `AppState.isAuthenticated` is `false`
- **THEN** the lock screen SHALL be displayed instead of the main tab/sidebar navigation

#### Scenario: Unlock triggers auth
- **WHEN** the user taps "Unlock" on the lock screen
- **THEN** `BiometricService.authenticate()` SHALL be called

### Requirement: Placeholder tab views
Each tab (Vault, Manage, Profile) SHALL have a placeholder view displaying the tab name and a brief description, ready to be replaced with feature implementations in subsequent changes.

#### Scenario: Vault placeholder
- **WHEN** the user navigates to the Vault tab
- **THEN** a placeholder view with "Vault" title and "Dashboard coming soon" message SHALL be displayed

### Requirement: App entry point restructure
The `CardVaultApp` SHALL replace the template `ContentView` with the authentication gate → main navigation flow. The template `Item` model SHALL be removed.

#### Scenario: Clean app structure
- **WHEN** the app is built
- **THEN** no references to the template `Item` model or `ContentView` SHALL exist

### Requirement: Localization infrastructure
The app SHALL include a `Localizable.xcstrings` String Catalog with entries for all user-facing strings in the foundation layer (tab names, auth screen text, button labels) in both `en` and `zh-Hans` locales.

#### Scenario: Chinese locale
- **WHEN** the device language is set to Simplified Chinese
- **THEN** all foundation-layer strings SHALL display in Chinese (e.g., "保险柜" for "Vault", "管理" for "Manage", "个人" for "Profile")
