## 1. Shared Components

- [x] 1.1 Create `CardStackItem` view: card tile with network badge, nickname, issuer, masked last 4 (SF Mono), expiry, status badge (Due/Paid/Overdue), balance, gradient background from `cardColor`, 24pt corner radius, no borders
- [x] 1.2 Create `TotalWealthCard` view: aggregate balance in `displayLG` font, growth percentage badge in capsule, freshness timestamp, adapts size for iOS vs macOS via parameter
- [x] 1.3 Create `SecurityRadarView` view: "Recent Security Events" header, list of `SecurityEvent` entries with icon (per event type), description, location, relative timestamp, `surfaceContainerLow` background
- [x] 1.4 Create `SampleData` helper with static preview instances: 3 sample `CreditCard`s (Travel Rewards/Amex, Sapphire Preferred/Visa, Daily Spending/Mastercard) and 3 sample `SecurityEvent`s matching Stitch comp content

## 2. iOS Vault Dashboard

- [x] 2.1 Create `VaultHeaderView`: lock.shield.fill icon + "The Vault" title (headlineSM) + settings gear, using onSurface text on surface background
- [x] 2.2 Create `CardStackView` (iOS): VStack with -160pt spacing, cards sorted by displayOrder, tap animation (spring translate up 20pt), scroll support via ScrollView
- [x] 2.3 Create `VaultEmptyStateView`: centered wallet icon, "Your vault is empty" title, "Add your first card" subtitle, "Add Card" PrimaryButtonStyle CTA
- [x] 2.4 Create `VaultView` (iOS root): ScrollView containing VaultHeaderView, TotalWealthCard, conditional CardStackView or VaultEmptyStateView, SecurityRadarView. Uses @Query for CreditCard and SecurityEvent data

## 3. macOS Vault Dashboard

- [x] 3.1 Create `VaultIntegrityView` (macOS only): score out of 100 based on security criteria, status label (Optimal/Good/At Risk), verified badge, last audit timestamp
- [x] 3.2 Create `VaultStreamView` (macOS only): transaction log timeline from SecurityEvent model, showing event name, timestamp, status badges, limited to 10 entries
- [x] 3.3 Create `QuickControlsView` (macOS only): horizontal row of 4 glass buttons — Lock All, History, Audit, Link — using surfaceContainerHigh background
- [x] 3.4 Create `VaultView` (macOS root): ScrollView with TotalWealthCard (large), LazyVGrid card display (2-3 columns), VaultIntegrityView, VaultStreamView, QuickControlsView, SecurityRadarView. Uses @Query for data

## 4. Platform-Adaptive VaultView

- [x] 4.1 Create unified `VaultView` with `#if os(iOS)` / `#if os(macOS)` to select the appropriate layout, replacing the placeholder view
- [x] 4.2 Update `MainTabView` to use the new `VaultView` instead of `VaultPlaceholderView`

## 5. Localization

- [x] 5.1 Add all vault dashboard strings to `Localizable.xcstrings` in en and zh-Hans: "The Vault", "Total Wealth", "Total Secured Value", "this month", "Updated %@ ago", "Recent Security Events", "No recent events", "Your vault is empty", "Add your first card to get started", "Add Card", "Vault Integrity", "Optimal", "Good", "At Risk", "Verified", "Vault Stream", "Lock All", "History", "Audit", "Link", "Due in %d days", "Paid", "Overdue", status labels

## 6. Build & Verify

- [x] 6.1 Build for iOS simulator and verify no compilation errors
- [x] 6.2 Build for macOS and verify no compilation errors
- [x] 6.3 Run existing unit tests to ensure no regressions
