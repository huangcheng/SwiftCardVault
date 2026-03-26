## Context

The Vault dashboard is the primary screen users see after biometric unlock. Design comps fetched from Stitch project `16203673754999454503`:
- Mobile Dark: screen `79ffe2be5d1c43b48041f28201c8e27d` — "Main: Card Stack"
- Mobile Light: screen `e7e79725014c406894d4876dc9cec431` — "Main: Card Stack (Light)"
- Desktop Light: screen `0efffef26ffb4adf87fa474720c9a661` — "Main: Dashboard (Desktop)"
- Desktop Dark: screen `aca80b8bf9a54998a2c30aa12288026a` — "Main: Dashboard (Desktop - Dark)"

## Goals / Non-Goals

**Goals:**
- Implement the full iOS mobile vault dashboard matching Stitch comps
- Implement the full macOS desktop vault dashboard matching Stitch comps
- Create reusable sub-components that can be shared between platforms
- Use Aether Glass design tokens for automatic dark/light mode support
- Use `@Query` to pull live data from SwiftData
- Show sample data when the vault is empty (empty state with add card prompt)

**Non-Goals:**
- Card detail sheet (tap-to-expand) — separate change
- Add card flow — separate change (Manage tab)
- Settings screen — separate change (Profile tab)
- Actual notification scheduling — uses existing model data only
- CloudKit sync configuration

## Decisions

### 1. Component Architecture

```
VaultView (platform-adaptive root)
├── iOS Layout
│   ├── VaultHeaderView (lock icon + title + settings)
│   ├── TotalWealthCard (aggregate balance + growth badge)
│   ├── CardStackView
│   │   └── CardStackItem (per-card tile with network badge, masked digits, status)
│   └── SecurityRadarView (recent security events list)
│
└── macOS Layout
    ├── TotalWealthCard (larger format, "Total Secured Value")
    ├── CardStackView (side-by-side multi-column, not overlapping)
    ├── VaultIntegrityView (score out of 100 + suggestions)
    ├── VaultStreamView (recent transaction log)
    └── QuickControlsView (Lock All, History, Audit, Link buttons)
```

**Why**: Shared components (TotalWealthCard, CardStackView, SecurityRadarView) adapt via parameters. Platform-specific views (VaultIntegrityView, VaultStreamView, QuickControlsView) are macOS-only.

### 2. Card Stack Interaction (iOS)

Cards use `VStack(spacing: -160)` for the wallet overlap effect. Each card responds to tap with `.spring(response: 0.4, dampingFraction: 0.7)` translating upward 20px. Uses `@State` for selected card index.

**Why**: Matches the PRD specification exactly. The negative spacing creates the stacked wallet depth effect.

### 3. Data Flow

- `@Query` for `[CreditCard]` sorted by `displayOrder`
- `@Query` for `[SecurityEvent]` sorted by `timestamp` descending, limited to 5
- Computed properties for total balance (sum of `currentBalance`), growth percentage (placeholder for now)
- Keychain data (full card number) NOT displayed on this screen — only `lastFourDigits`

### 4. Empty State

When no cards exist, show centered illustration + "Your vault is empty" + "Add your first card to get started" + primary CTA button.

### 5. Sample Data for Previews

Create a `SampleData` helper with static preview card/event instances for SwiftUI previews, matching the Stitch comp content (Travel Rewards, Sapphire Preferred, Daily Spending cards).

## Risks / Trade-offs

- **[Risk] Card overlap may clip content on small screens** → Use `ScrollView` with `.scrollClipDisabled()` on iOS to allow overflow
- **[Trade-off] macOS-only views increase file count** → Necessary for platform-appropriate layouts per PRD. Use `#if os(macOS)` compilation conditions.
- **[Risk] Empty database on first launch shows blank screen** → Empty state design handles this gracefully
