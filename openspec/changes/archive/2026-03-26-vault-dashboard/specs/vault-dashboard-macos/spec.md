## ADDED Requirements

### Requirement: macOS expanded vault layout
The macOS vault dashboard SHALL display an expanded multi-section layout within the `NavigationSplitView` detail area. The layout SHALL include: Total Secured Value metric, active cards in side-by-side columns, vault integrity score, vault stream (transaction log), and quick controls. All sections SHALL use tonal background shifts (No-Line Rule) for separation.

#### Scenario: Desktop dashboard rendering
- **WHEN** the vault tab is displayed on macOS
- **THEN** the expanded layout with all 5 sections SHALL be visible in a scrollable view

### Requirement: Total Secured Value (macOS variant)
The macOS vault SHALL display the total secured value in a prominent card with `displayLG` font, accompanied by a trend percentage badge with up/down arrow icon. The card SHALL use `surfaceContainerLow` background.

#### Scenario: Total secured value display
- **WHEN** cards have aggregate balance of $142,850.52
- **THEN** the total secured value SHALL display "$142,850.52" with trend indicator

### Requirement: Multi-column card display (macOS)
On macOS, cards SHALL be displayed in a side-by-side grid layout (2-3 columns depending on window width) using `LazyVGrid` rather than the overlapping stack used on iOS. Each card SHALL show full details: network badge, masked number, cardholder name, expiry, status, and balance.

#### Scenario: Cards in grid layout
- **WHEN** 3 cards exist on macOS
- **THEN** they SHALL be displayed in a multi-column grid, not overlapping

### Requirement: Vault integrity score (macOS only)
The macOS vault SHALL display a vault integrity score section showing: a score out of 100 (e.g., "96/100"), a status label ("Optimal" / "Good" / "At Risk"), improvement suggestions, and a "Verified" badge with last audit timestamp. The score SHALL be calculated based on: biometric enabled (+25), all cards encrypted (+25), no expired cards (+25), all payments current (+25).

#### Scenario: Optimal score
- **WHEN** all security criteria are met
- **THEN** the vault integrity score SHALL show "96/100 — Optimal" with a verified badge

### Requirement: Vault stream transaction log (macOS only)
The macOS vault SHALL display a "Vault Stream" section showing recent card activity as a timeline list. Each entry SHALL show: merchant/event name, card used, timestamp, amount (for transactions), and status badge (Verified/Authorized/Pending). Limited to the 10 most recent entries. Uses `SecurityEvent` model data.

#### Scenario: Transaction log display
- **WHEN** security events exist
- **THEN** they SHALL appear as a timeline with appropriate icons and formatted timestamps

### Requirement: Quick controls (macOS only)
The macOS vault SHALL display a row of quick action buttons: "Lock All" (lock icon), "History" (clock icon), "Audit" (checkmark.shield icon), and "Link" (link icon). Each button SHALL use the secondary glass button style (`surfaceContainerHigh` background with `onSurface` text).

#### Scenario: Quick controls rendering
- **WHEN** the macOS vault is displayed
- **THEN** the 4 quick control buttons SHALL be visible in a horizontal row

### Requirement: Shared components between platforms
`TotalWealthCard`, `CardStackItem`, and `SecurityRadarView` SHALL be implemented as platform-agnostic SwiftUI views that adapt their sizing and layout based on the platform context. Platform-specific wrapping (VStack overlap vs LazyVGrid) SHALL be in the parent views.

#### Scenario: Shared card item
- **WHEN** `CardStackItem` is used on both iOS and macOS
- **THEN** it SHALL render appropriately with the same data but platform-adapted sizing
