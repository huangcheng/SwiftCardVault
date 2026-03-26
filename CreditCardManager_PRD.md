# Product Requirements Document
## CardVault — "The Vault" Credit Card Management App (Apple Platforms)

| Field | Value |
|---|---|
| **Version** | 2.0 |
| **Date** | 2026-03-26 |
| **Platform** | iOS 18+ / macOS 15+ (Multiplatform SwiftUI) |
| **Design Language** | Liquid Glass & Secure Depth ("The Digital Vault") |
| **Languages** | English (en), Simplified Chinese (zh-Hans) |
| **Status** | Initial — Xcode multiplatform template created |

---

## 1. Executive Summary

CardVault — branded as **"The Vault"** — is a multiplatform Apple application that helps users organize, track, and manage their credit cards in one secure place. The product embodies a **"Digital Vault"** aesthetic: the UI feels like polished obsidian and frosted glass layered atop one another, creating a premium editorial experience for one's financial identity. CardVault ships as a single SwiftUI codebase targeting both iOS and macOS, with platform-adaptive navigation and layout.

A companion Qt-based version exists for Windows and Linux (see `QCardVault` repo).

### 1.1 Problem Statement

Modern consumers hold an average of 3-5 credit cards. Managing billing dates, payment due dates, expiration dates, credit limits, and security across these cards is error-prone. A missed payment can damage credit scores, trigger late fees, and cause cascading financial consequences. No mainstream app today focuses purely on **card lifecycle management** with a security-first vault paradigm across Apple's ecosystem.

### 1.2 Product Vision

> A minimal, beautiful, and impenetrably secure vault for every credit card you own — never miss a payment, never forget an expiration, always know your financial posture.

### 1.3 Target Audience

| Segment | Description |
|---|---|
| Primary | Adults (25-55) who hold 3+ credit cards and want centralized management with premium security |
| Secondary | Young professionals building credit who want proactive reminders and financial health tracking |
| Tertiary | Frequent travelers managing cards across multiple issuers/countries |

---

## 2. Design Principles

| # | Principle | Rationale |
|---|---|---|
| 1 | **Security First** | The app stores highly sensitive financial data. Every architectural and UX decision defaults to the most secure option. The UI reinforces this through vault metaphors and real-time security status. |
| 2 | **The Digital Vault** | The UI feels like sheets of polished obsidian and frosted glass stacked atop one another. We break the "template" look with exaggerated typographic scales and asymmetrical layouts. |
| 3 | **Platform Native** | SwiftUI with Liquid Glass materials on iOS and macOS. Platform-adaptive navigation (tab bar on iOS, sidebar on macOS). |
| 4 | **Proactive, Not Reactive** | The app surfaces critical dates, security events, and financial health insights before the user has to look for them. |
| 5 | **No-Line Rule** | Boundaries are defined through background color shifts and Liquid Glass materials, never 1px solid borders. Depth comes from light, not lines. |

---

## 3. Information Architecture

```
The Vault (CardVault)
 |
 +-- Vault (Main Dashboard)                <-- Tab 1
 |    +-- Total Wealth / Liquidity Overview
 |    +-- Stacked Card Display
 |    +-- Security Events / Security Radar
 |    +-- Quick Controls (macOS)
 |    +-- Vault Integrity Score
 |    +-- Card Detail Sheet (tap to expand)
 |         +-- Full Card Visual
 |         +-- Billing Cycle Timeline
 |         +-- Quick Actions
 |
 +-- Manage (Card CRUD)                    <-- Tab 2
 |    +-- Card List with Status Indicators
 |    +-- Vault Security Status Panel
 |    +-- Add Card Flow ("New Asset")
 |    +-- Edit Card Flow
 |    +-- Delete Card (with confirmation)
 |    +-- Card Vulnerability Alerts
 |    +-- Aggregate Metrics (macOS)
 |
 +-- Profile (Stats & Settings)            <-- Tab 3
      +-- User Profile Header
      +-- Financial Health Score
      +-- Credit Capacity & Utilization
      +-- Network Distribution Chart
      +-- Upcoming Payments (with actions)
      +-- Spending Categories
      +-- Utilization Trend Chart
      +-- Security Toggles
      +-- Risk Management Concierge (Premium)
```

---

## 4. Feature Specification

### 4.1 Vault Page (Main Dashboard)

**Purpose:** At-a-glance view of total financial posture, card stack, and security status. This is the app's hero screen.

#### 4.1.1 Layout — iOS

- **Header bar:** Lock icon + "The Vault" title + settings gear icon (top-right)
- **Total Wealth metric:** Large display numeral (3.5rem equivalent) showing aggregate value across all cards
  - Growth indicator badge (e.g., "+2.4% this month")
  - Subtitle: "Updated 2m ago" or similar freshness timestamp
- **Stacked Card Display:** Cards rendered as overlapping tiles with -160px vertical overlap
  - Each card shows: network badge, card nickname, masked last 4 digits (e.g., ".... 4242"), expiration date, status badge ("Due in 3 days" / "Paid" / "Overdue"), and card balance amount
  - Touch: cards translate upward 20px with spring animation
- **Security Radar:** Section below cards listing recent security-relevant activity
  - Examples: "Encryption Updated — 2 hours ago", "New Login Detected — San Francisco, CA"
  - Security status indicators: Encryption Active (256-bit AES), 2FA Verified (Face ID), Card Freezing Auto-Active
- **Bottom navigation:** 3-tab bar — Vault (wallet icon), Manage (credit card icon), Profile (person icon)

#### 4.1.2 Layout — macOS

- **Sidebar navigation:** CardVault logo + lock icon, navigation items (Vault / Manage / Profile), "Add New Card" button
- **Toolbar:** Search button, notification bell, settings icon, user profile (name + "Premium Member" badge + avatar)
- **Total Secured Value:** Large metric with trend percentage
- **Active Card Display:** Multiple card visuals shown side-by-side (multi-column layout)
- **Vault Integrity Score:** Prominent score display (e.g., "96/100 — Optimal") with suggestion to improve
- **Vault Stream:** Real-time transaction log with entries showing merchant name, amount, timestamp, and status badges
- **Quick Controls:** Lock All, History, Audit, Link buttons

#### 4.1.3 Interactions

| Gesture / Action | Behavior |
|---|---|
| Tap a card | Expand to Card Detail Sheet (see 4.1.4) |
| Long press a card | Context menu: View Details, Edit, Copy Card Number |
| Drag to reorder | Change card display order |
| Pull down (iOS) | Refresh reminders / sync status |
| Hover (macOS) | Card translates upward 20px with smooth easing |

#### 4.1.4 Card Detail Sheet

When a card is tapped, an expanded detail view appears with:

| Section | Content |
|---|---|
| **Card Visual** | Full card rendering: full card number (after Face ID / Touch ID auth, monospaced font), expiration date (MM/YY), CVV (tap to reveal with biometric auth), cardholder name (e.g., "ALEXANDER VAULT"), issuer logo, verification badge, card type badge (e.g., "Visa Signature"), gradient background |
| **Billing Cycle** | 4 date tiles arranged horizontally: "Due in N days" countdown, Statement Opened date, Statement Closed date, Due Date — each as a distinct tile |
| **Quick Actions** | Button row: Copy Number, Mark as Paid, Edit, Lock The Vault |

#### 4.1.5 Empty State

When no cards exist, display a centered illustration with the message:
> "Add your first card to get started."
>
> [+ Add Card] button

---

### 4.2 Manage Page — Card CRUD

**Purpose:** Full lifecycle management of card entries with vault security status.

#### 4.2.1 Card List View — iOS

- **Header:** Lock icon + "Manage" title + settings icon
- **"My Cards" subheading** with descriptive subtitle
- Each card entry displays:
  - Branded card image/icon with network logo
  - Card nickname and issuer name
  - Masked last 4 digits (e.g., ".... 4412")
  - Status indicator badge: "Due in 4d" (warning), "Paid" (success), "Overdue" (error), date
  - Payment amount when applicable
- **Vault Security Status Panel** at bottom:
  - "All N cards are currently encrypted and locked behind biometric authentication"
  - Encryption and lock status per card
- Swipe-to-delete with confirmation alert
- Tap to enter Edit Card flow
- Floating "+" button to Add Card

#### 4.2.2 Card List View — macOS

- **Toolbar controls:** Search, notifications, settings, user profile
- **"Manage Cards" heading** with subtitle: "You have N active cards in your secure vault"
- **Filter button** + **"Add New Card"** action button
- Each card entry (wider layout):
  - Brand logo (Visa/MC/Amex), card name, category label (e.g., "Travel", "Commercial", "Digital")
  - Masked number, status badge (Active / Auto-Pay / Attention / Digital)
  - Next due date and payment amount
  - **Visibility toggle** (eye icon) + **Lock status control** (lock/unlock)
  - Edit + overflow menu buttons
  - **Vulnerability alerts** for unsecured cards
- **Bottom metrics row** (3-4 cards):
  - Total Credit Limit, Overall Utilization, Active Security status, Upcoming Payments total

#### 4.2.3 Add Card Flow ("New Asset")

A multi-step form presented as a sheet, using vault-themed language:

**Step 1 — "New Asset" (Card Input)**

| Field | Type | Required | Notes |
|---|---|---|---|
| Card Number | Numeric (16-19 digits) | Yes | Auto-formatted with spaces every 4 digits; Luhn validation; credit card icon |
| Card Network | Radio button group | Yes | Amex, Visa, Mastercard, UnionPay, JCB (auto-detected from BIN, manual override available) |
| Cardholder Name | Text | Yes | |
| Expiration Date | Date (MM/YY) | Yes | |
| Security Code (CVV) | Numeric (3-4 digits) | Yes | Hidden by default |

CTA: **"Continue to Terms"** button with arrow icon

**Step 2 — "Financial Cycles" (Billing Configuration)**

| Field | Type | Required | Notes |
|---|---|---|---|
| Billing Date | Dropdown (Day 1/5/15/20/28/30) | Yes | The date the statement is generated |
| Due Date | Dropdown | Yes | The date payment is due |
| Credit Limit | Currency ($) | No | Used for statistics and utilization tracking |

Buttons: **Back** + **"Review Vault"**

**Step 3 — "Ready for Encryption" (Confirmation)**

- Card preview rendering with all entered data in vault aesthetic
- Shows: Card nickname, masked card number, expiry, hidden CVV, cardholder name
- Verification badge on cardholder
- CTA: **"Finalize Vault Entry"** + Cancel button

**Optional:** Camera-based card scanning using Vision framework (`VNRecognizeTextRequest`) to OCR card number, name, and expiration from a photo.

#### 4.2.4 Edit Card Flow

- Same form as Add Card, pre-populated with existing data.
- Changes to sensitive fields (card number, CVV) require biometric confirmation before saving.

#### 4.2.5 Delete Card

- Triggered via swipe-to-delete (iOS) or Edit screen / context menu.
- Two-step confirmation:
  1. Alert: "Delete [Card Nickname]? This cannot be undone."
  2. Require biometric authentication to confirm deletion.

---

### 4.3 Profile Page — Statistics & Settings

**Purpose:** Surface financial health insights, portfolio analytics, upcoming payments, and security configuration.

#### 4.3.1 User Profile Header

- User avatar with verification badge
- Full name (e.g., "Alex Hamilton")
- Membership badge: "Premium Vault Member"
- Glass-morphic card background

#### 4.3.2 Financial Health Score

| Metric | Description | Visualization |
|---|---|---|
| Health Score | Aggregate financial health rating | Large numeral (e.g., "782") with trend indicator (e.g., "+14") |
| Total Credit Capacity | Sum of all configured credit limits | Formatted currency (e.g., "$42,500") |
| Available Balance | Remaining available credit | Formatted currency (e.g., "$31.2k") |
| Utilized Amount | Total credit currently used | Formatted currency |
| Utilization Ratio | Used / Total as percentage | Percentage with trend (e.g., "14.5% — +12% from last quarter") |

#### 4.3.3 Network Distribution & Utilization

- **Pie/Donut chart** (Swift Charts) showing card distribution by network (e.g., Visa 42%, Mastercard 26%, Amex 32%)
- **Overall utilization percentage** prominently displayed
- **Card Portfolio summary:** Total card count broken down by network and tier

#### 4.3.4 Upcoming Payments

Interactive list of upcoming payments across all cards:

| Column | Content |
|---|---|
| Card name | e.g., "Platinum Rewards" |
| Amount | e.g., "$1,240.00" |
| Due timing | e.g., "Due in 3 days" / "Due in 12 days" |
| Action | **PAY NOW** button (urgent) or **SCHEDULED** badge |

macOS view shows a 14-day payment timeline graph with weekly/monthly toggle.

#### 4.3.5 Spending Categories

Breakdown of spending across categories with transaction counts and amounts:

| Category | Example |
|---|---|
| Mortgage & Rent | $6,500 (42%) |
| Dining & Travel | $4,280 (34%) |
| Luxury Retail | $2,150 (18%) |
| Tech & SaaS | $940 (6%) |

#### 4.3.6 Utilization Trend Chart

Monthly utilization trend line chart (Swift Charts) showing historical utilization over time.

#### 4.3.7 Security Toggles

| Setting | Default | Type |
|---|---|---|
| Notifications (for reminders) | On | Toggle |
| Biometric Vault Lock (Face ID / Touch ID) | On (mandatory) | Toggle (cannot be disabled) |
| iCloud Sync | On | Toggle |

#### 4.3.8 Additional Settings

| Setting | Description |
|---|---|
| Auto-Lock Timeout | Lock app after 30s / 1min / 5min of inactivity |
| Hide Sensitive Data | Mask card numbers and CVVs on Vault page (on by default) |
| Clipboard Auto-Clear | Auto-clear copied card data from clipboard after 30 seconds |
| Export Data | Export all card data as encrypted `.vault` archive (cross-platform compatible) |
| Delete All Data | Wipe all stored data with biometric confirmation |

#### 4.3.9 Notification Preferences

| Setting | Default | Options |
|---|---|---|
| Payment Due Reminder | On | Off / 1 day before / 3 days before / 7 days before / Custom |
| Billing Date Reminder | On | Off / On billing date / 1 day before |
| Expiration Reminder | On | Off / 30 days / 60 days / 90 days before |
| Notification Style | Banner | Banner / Alert / Badge Only |

#### 4.3.10 Vault Security Score

- Score out of 100 (e.g., "96/100 — Optimal")
- Real-time vault integrity monitoring
- "Verified" badge
- Last audit timestamp

#### 4.3.11 Risk Management Concierge (Premium Feature)

- Promotional card for premium users
- Alert notification count
- "Consult Now" / "Upgrade to Platinum" CTA

---

## 5. Security Architecture

### 5.1 Threat Model

| Threat | Mitigation |
|---|---|
| Device theft / unauthorized access | Mandatory biometric auth (Face ID / Touch ID) on every app launch; auto-lock on background |
| Data leakage from storage | Card numbers and CVVs encrypted in Keychain with `.whenUnlockedThisDeviceOnly`; metadata in SwiftData |
| Clipboard snooping | Auto-clear clipboard after 30 seconds; `UIPasteboard` privacy settings |
| Screenshot / screen recording | Hide sensitive data when app enters background (`UIApplication.willResignActiveNotification` / `NSApplication.willResignActiveNotification`) |
| Cloud data breach | End-to-end encryption before CloudKit sync; encryption key never leaves device |
| Memory dump | Sensitive strings cleared from memory after use; use `Data` / `ContiguousBytes` for secrets |
| Card vulnerability | Per-card lock/unlock status with visual alerts for unsecured cards |

### 5.2 Data Storage

```
+---------------------------+
|  Apple Keychain Services  |  <-- Card numbers, CVVs (kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
+---------------------------+
             |
+---------------------------+
|  SwiftData                |  <-- Card metadata (nickname, dates, colors, limits, balances)
+---------------------------+
             |
+---------------------------+
|  CloudKit (Private DB)    |  <-- Encrypted sync across user's Apple devices (optional)
+---------------------------+
             |
+---------------------------+
|  Encrypted .vault Export  |  <-- Cross-platform transfer (AES-256-GCM, Argon2id KDF)
+---------------------------+
```

- **Keychain:** All PCI-sensitive data (full card number, CVV) stored exclusively in the Keychain with `kSecAttrAccessibleWhenUnlockedThisDeviceOnly` protection class.
- **SwiftData:** Non-sensitive metadata (nicknames, billing dates, colors, limits, balances, spending categories) stored in SwiftData with automatic CloudKit sync.
- **CloudKit:** When iCloud Sync is enabled, SwiftData automatically syncs metadata to the user's private CloudKit database. Keychain secrets are synced separately via iCloud Keychain (if the user has it enabled system-wide).
- **Cross-Platform Export:** For transferring data to/from the Qt version (Windows/Linux), an encrypted `.vault` file can be exported. This file uses AES-256-GCM with a user-provided passphrase derived via Argon2id — the same format used by the Qt version.

### 5.3 Authentication Flow

```
App Launch / Foreground
        |
        v
  [Biometric Prompt]
   Face ID / Touch ID
        |
   +----+----+
   |         |
Success    Failure
   |         |
   v         v
 Unlock   [Retry] x3 --> [Device Passcode Fallback] --> [Locked Out]
```

- Biometric authentication is **mandatory** — there is no option to disable it.
- Face ID / Touch ID via `LAContext` with device passcode fallback.
- After 3 failed biometric attempts, fall back to device passcode.
- After passcode failure, the app locks for a configurable cooldown period.
- No separate master password on Apple platforms — the Keychain + biometric model provides hardware-backed security superior to a user-chosen password.

---

## 6. Technical Architecture

### 6.1 Technology Stack

| Layer | Technology |
|---|---|
| UI Framework | SwiftUI (Liquid Glass materials, SF Symbols 7) |
| Data Persistence | SwiftData (metadata), Keychain Services (secrets) |
| Cloud Sync | CloudKit (Private Database, automatic via SwiftData) |
| Notifications | UserNotifications + `UNCalendarNotificationTrigger` |
| Card Scanning | Vision framework (`VNRecognizeTextRequest`) |
| Charts | Swift Charts |
| Biometrics | LocalAuthentication (`LAContext`) — Face ID / Touch ID |
| Cross-Platform Export | CryptoKit (AES-256-GCM) + Argon2id (via swift-crypto or libsodium) |
| Minimum Deployment | iOS 18.0 / macOS 15.0 |

### 6.2 Data Model

```swift
import SwiftData

@Model
final class CreditCard {
    var id: UUID = UUID()
    var nickname: String = ""
    var cardholderName: String = ""
    var lastFourDigits: String = ""          // derived, stored for display
    var cardNetwork: CardNetwork = .visa     // enum: visa, mastercard, amex, unionpay, jcb, discover
    var cardCategory: String = ""            // e.g., "Travel", "Commercial", "Digital"
    var issuerName: String = ""
    var expirationMonth: Int = 1
    var expirationYear: Int = 2026
    var billingDate: Int = 1                 // day of month (1-31)
    var paymentDueDate: Int = 1              // day of month (1-31)
    var creditLimit: Decimal?
    var currentBalance: Decimal?             // card balance for Total Wealth display
    var cardColor: String = "#3e90ff"        // hex color code
    var displayOrder: Int = 0
    var isPaidThisCycle: Bool = false
    var isLocked: Bool = false               // per-card lock/unlock status
    var createdAt: Date = Date()
    var updatedAt: Date = Date()

    // Sensitive fields NOT stored here — stored in Keychain
    // - Full card number  -> Keychain key: "card_number_\(id)"
    // - CVV               -> Keychain key: "card_cvv_\(id)"
}

@Model
final class SecurityEvent {
    var id: UUID = UUID()
    var eventType: SecurityEventType = .loginDetected
    var eventDescription: String = ""
    var location: String?                    // e.g., "San Francisco, CA"
    var riskLevel: RiskLevel = .low          // enum: low, medium, high
    var timestamp: Date = Date()
}

@Model
final class SpendingCategory {
    var id: UUID = UUID()
    var name: String = ""                    // e.g., "Mortgage & Rent", "Dining & Travel"
    var amount: Decimal = 0
    var percentage: Double = 0
    var transactionCount: Int = 0
    var period: Date = Date()                // month/year for the record
}
```

### 6.3 Project Structure

```
CardVault/
 +-- App/
 |    +-- CardVaultApp.swift                // App entry point + ModelContainer setup
 |    +-- AppState.swift                    // Global app state (ObservableObject)
 |
 +-- Features/
 |    +-- Vault/
 |    |    +-- VaultView.swift              // Main dashboard (platform-adaptive)
 |    |    +-- TotalWealthCard.swift        // Total Wealth / Liquidity display
 |    |    +-- CardStackView.swift          // Stacked card display
 |    |    +-- CardStackItem.swift          // Individual card in stack
 |    |    +-- CardDetailSheet.swift        // Expanded card detail
 |    |    +-- SecurityRadarView.swift      // Security events list
 |    |    +-- VaultIntegrityView.swift     // Vault integrity score
 |    |    +-- VaultStreamView.swift        // Real-time transaction log (macOS)
 |    |    +-- QuickControlsView.swift      // Lock All / History / Audit / Link (macOS)
 |    |
 |    +-- Manage/
 |    |    +-- ManageView.swift             // Card list (platform-adaptive)
 |    |    +-- AddCardFlow.swift            // Multi-step "New Asset" form
 |    |    +-- EditCardView.swift           // Edit form
 |    |    +-- CardScannerView.swift        // Camera OCR scanning
 |    |    +-- VaultSecurityPanel.swift     // Vault security status
 |    |    +-- CardMetricsView.swift        // Aggregate metrics (macOS)
 |    |
 |    +-- Profile/
 |         +-- ProfileView.swift            // Stats & settings (platform-adaptive)
 |         +-- ProfileHeaderView.swift      // User avatar + membership badge
 |         +-- HealthScoreView.swift        // Financial health score
 |         +-- CreditCapacityView.swift     // Credit capacity & utilization
 |         +-- NetworkDistributionView.swift // Pie chart (Swift Charts)
 |         +-- UpcomingPaymentsView.swift   // Payments with actions
 |         +-- SpendingCategoriesView.swift // Spending breakdown
 |         +-- UtilizationTrendView.swift   // Utilization trend chart
 |         +-- SecurityTogglesView.swift    // Security toggle switches
 |         +-- SettingsView.swift           // Preferences
 |
 +-- Core/
 |    +-- Models/
 |    |    +-- CreditCard.swift             // SwiftData model
 |    |    +-- CardNetwork.swift            // Network enum
 |    |    +-- SecurityEvent.swift          // Security event model
 |    |    +-- SpendingCategory.swift       // Spending category model
 |    |
 |    +-- Services/
 |    |    +-- KeychainService.swift        // Keychain CRUD wrapper
 |    |    +-- BiometricService.swift       // Face ID / Touch ID (LAContext)
 |    |    +-- NotificationService.swift    // Schedule reminders
 |    |    +-- CloudSyncService.swift       // CloudKit sync configuration
 |    |    +-- CardScanService.swift        // Vision OCR
 |    |    +-- ExportImportService.swift    // Cross-platform .vault export/import
 |    |    +-- SecurityMonitorService.swift // Security event tracking
 |    |    +-- HealthScoreService.swift     // Financial health calculation
 |    |
 |    +-- Utilities/
 |         +-- LuhnValidator.swift          // Card number validation
 |         +-- CardNetworkDetector.swift    // BIN-based detection
 |         +-- CryptoHelper.swift           // AES-256-GCM encryption (CryptoKit)
 |         +-- ClipboardManager.swift       // Auto-clear clipboard
 |
 +-- Resources/
      +-- Assets.xcassets                   // Colors, card backgrounds, icons
      +-- Localizable.xcstrings            // Localization (en, zh-Hans)
```

---

## 7. User Experience Flows

### 7.1 First Launch

```
[Welcome Screen]
  "The Vault keeps your cards organized and your payments on time."
        |
        v
[Biometric Setup]
  "Enable Face ID to protect your vault."
  [Enable Face ID]          --> System biometric prompt
        |
        v
[Notification Permission]
  "Get reminders before payments are due."
  [Allow Notifications]     --> System notification prompt
        |
        v
[Add First Card — "New Asset"]
  "Add your first card to secure it in the vault."
  [+ Add Card]              --> Add Card Flow (4.2.3)
  [Skip for now]            --> Vault Page (empty state)
```

### 7.2 Daily Usage — Payment Reminder

```
[Push Notification]
  "Chase Sapphire payment due in 3 days — $1,240.00"
        |
  User taps notification
        |
        v
[App Opens -> Face ID Auth -> Card Detail Sheet]
  Payment due date highlighted on billing cycle timeline
  [Mark as Paid] button
  [PAY NOW] button (Profile upcoming payments)
```

### 7.3 Card Expiration Flow

```
[Push Notification — 90 days before]
  "Your Amex Gold expires in 90 days (06/26). Contact your issuer for a replacement."
        |
[Push Notification — 30 days before]
  "Your Amex Gold expires next month. Have you received your new card?"
        |
[Card Detail — After Expiration]
  Card visual shows "EXPIRED" overlay badge
  [Update Card] button prominent
```

---

## 8. Visual Design Guidelines

### 8.1 Design System: "Liquid Glass & Secure Depth"

The design system follows the **"Digital Vault"** creative direction, enhanced with Apple's Liquid Glass materials on iOS/macOS.

#### Core Principles

| Principle | Implementation |
|---|---|
| **No-Line Rule** | Prohibit 1px solid borders. Boundaries via background color shifts and Liquid Glass layering. |
| **Glass & Gradient Rule** | Main CTAs and brand cards use vibrant gradients. Leverage `.glassEffect()` modifier for frosted glass panels. |
| **Intentional Layering** | UI as physical stack: deeper = lower surface token, more interactive = higher surface token. |
| **Ambient Shadows** | Only on floating elements. Use `.shadow(radius: 40)` with subtle opacity. |

### 8.2 Color System

#### Dark Mode Tokens

| Token | Value | Usage |
|---|---|---|
| `surface` | `#131313` | Base background (never pure black) |
| `surface-container-low` | `#1c1b1b` | Section backgrounds |
| `surface-container` | `#201f1f` | Standard cards |
| `surface-container-high` | `#2a2a2a` | Elevated elements |
| `surface-container-highest` | `#353534` | Active states, hover states |
| `surface-bright` | `#393939` | Input focus states |
| `primary` | `#aac7ff` | Primary actions, links, active indicators |
| `primary-container` | `#3e90ff` | Card gradients, CTAs |
| `secondary` | `#c6c6cb` | Secondary text |
| `tertiary` | `#c2c1ff` | Purple accents |
| `tertiary-container` | `#8382ff` | Warning/pending states |
| `error` | `#ffb4ab` | Error text, critical alerts (never as solid background) |
| `on-surface` | `#e5e2e1` | Primary text on dark backgrounds |
| `on-surface-variant` | `#c0c6d6` | Secondary text, labels |

#### Light Mode Tokens

| Token | Value | Usage |
|---|---|---|
| Background | `#f7f9fb` | Base background |
| `primary` | `#0058bc` | Primary actions |
| `secondary` | `#515f74` | Secondary text |
| `tertiary` | `#574fad` | Purple accents |
| `error` | `#ba1a1a` | Error states |

### 8.3 Typography

Dual-font pairing for precision and luxury:

| Level | Font Family | Size | Intent |
|---|---|---|---|
| **Display-LG** | Manrope | 3.5rem | Hero balances, "Total Wealth" numbers |
| **Headline-SM** | Manrope | 1.5rem | Section headers. Tight letter-spacing (-0.02em) |
| **Title-MD** | Plus Jakarta Sans | 1.125rem | Cardholder names, primary navigation labels |
| **Body-MD** | Plus Jakarta Sans | 0.875rem | General metadata and descriptions |
| **Label-SM** | Plus Jakarta Sans | 0.6875rem | Micro-copy (expiry dates, CVV labels) |
| **Card Numbers** | SF Mono | varies | Embossed physical card feel |

### 8.4 Component Specifications

#### Stacked Card Display (The Signature Component)

- **Structure:** No borders. Uses `.clipShape(RoundedRectangle(cornerRadius: 24))`.
- **Material:** Vibrant gradient base + Liquid Glass overlay at 20% opacity.
- **Overlap:** -160px vertical overlap between cards for wallet depth effect.
- **Touch animation:** `.spring(response: 0.4, dampingFraction: 0.7)` translate upward 20px.
- **Content:** Monospaced card numbers (SF Mono), network badge (SF Symbols), status badge, balance amount.

#### Buttons

| Type | Style |
|---|---|
| Primary | `primary` (#aac7ff) background with `on-primary` text. `.clipShape(Capsule())` |
| Secondary (Glass) | `.glassEffect()` with `.thinMaterial` |
| Interaction | `.scaleEffect(1.02)` on press (not just color change) |

### 8.5 Platform-Adaptive Navigation

#### iOS Navigation

3-tab `TabView`:
- **Vault** (SF Symbol: `wallet.bifold`) — active state uses `primary` color
- **Manage** (SF Symbol: `creditcard`)
- **Profile** (SF Symbol: `person.crop.circle`)

#### macOS Navigation

`NavigationSplitView` with sidebar:
- CardVault logo + "Premium Security" branding + lock icon
- Navigation items: Vault / Manage / Profile
- "Add New Card" button at sidebar bottom
- Toolbar: Search, Notification bell, Settings gear, User info

### 8.6 Dark Mode

- Full support for both light and dark appearances via system setting.
- Automatic via `@Environment(\.colorScheme)`.
- Card colors maintain vibrancy in both modes.
- Sensitive data masks use secondary fill color.
- **Dark default:** `#131313` (never pure black) to ensure depth visibility.

### 8.7 Do's and Don'ts

#### Do

- **Use Asymmetry:** Offset card balances to top-left while putting "Add Funds" in bottom-right for diagonal visual flow.
- **Use SF Symbols 7:** Utilize "Variable Color" and "Animate" features for secure state indicators (e.g., pulsing lock icon).
- **Embrace Negative Space:** Use generous spacing between major functional groups for an expensive, editorial feel.
- **Use Liquid Glass:** Apply `.glassEffect()` to floating panels, sheets, and navigation elements.

#### Don't

- **Don't use pure black:** Use `surface` (#131313) to ensure depth is visible in dark mode.
- **Don't use 1px dividers:** Separate content with spacing or tonal background shift.
- **Don't use "Default" Shadows:** Think "Atmospheric Glow," not "Drop Shadow."
- **Don't use borders for containment:** Use surface tier contrast instead.

---

## 9. Accessibility

| Requirement | Implementation |
|---|---|
| VoiceOver | `accessibilityLabel` and `accessibilityHint` on all interactive elements |
| Dynamic Type | All text scales with user's preferred font size via SwiftUI's built-in support |
| Reduce Motion | Disable card stack animations, hover translations when `accessibilityReduceMotion` is enabled |
| Color Blind | Status indicators use icons (SF Symbols) in addition to color |
| Keyboard Navigation | Full keyboard support on macOS (Tab order, Enter/Space activation) |
| High Contrast | Ensure glass-morphism effects degrade gracefully to solid backgrounds in high-contrast modes |

---

## 10. Platform-Specific Considerations

### 10.1 iOS

- Optimized for iPhone; supports all screen sizes (SE through Pro Max).
- iPad support with adaptive layout (multi-column on larger screens).
- Home Screen widget: "Next Payment Due" (small/medium sizes) using WidgetKit.
- Lock Screen widget: countdown to next due date.

### 10.2 macOS

- Native macOS app via SwiftUI multiplatform target (same codebase as iOS).
- Multi-column layout with sidebar navigation.
- Menu bar utility: quick-access popover showing upcoming due dates.
- Keyboard shortcuts for common actions (Cmd+N to add card, Cmd+F to search).

---

## 11. Notifications Strategy

| Event | Trigger | Priority |
|---|---|---|
| Payment due (configurable) | Calendar trigger on (due date - N days) | Time Sensitive |
| Billing date reminder | Calendar trigger on billing date | Default |
| Card expiring | Calendar trigger at 90/60/30 days before expiry | Default |
| Card expired | Calendar trigger on expiry date | Time Sensitive |
| Security event | Real-time on login detection, CVV attempt, key rotation | High |

- All notifications scheduled locally — no server dependency.
- Notifications recalculated when card data changes or at app launch.
- Uses `UNNotificationCategory` with actions: "Mark as Paid", "View Card".

---

## 12. Privacy & Compliance

| Area | Policy |
|---|---|
| Data Collection | Zero telemetry. No analytics SDK. No network calls except CloudKit sync. |
| Third-Party SDKs | None — pure first-party Apple frameworks only. |
| Data Residency | All data on-device or in user's private iCloud container. |
| PCI DSS | App does not process payments, but follows PCI best practices for data-at-rest encryption. |
| App Store Privacy Label | Data types: Financial Info (card numbers) — stored on device, linked to user, encrypted. |
| GDPR / CCPA | Full data export and deletion available in Profile > Settings. |
| App Transport Security | No outbound network connections except CloudKit. ATS enabled. |

---

## 13. Internationalization (i18n)

### 13.1 Supported Languages (v1.0)

| Language | Locale Code | Status |
|---|---|---|
| English | `en` | Primary (default) |
| Simplified Chinese | `zh-Hans` | Full translation required for v1.0 |

### 13.2 Implementation

- All user-facing strings externalized to `Localizable.xcstrings` (Xcode String Catalog format).
- Use `String(localized:)` / `LocalizedStringKey` throughout SwiftUI views — no hardcoded strings.
- `.lproj` bundles: `en.lproj`, `zh-Hans.lproj`.
- Plural rules handled via Xcode String Catalog's automatic plural support.
- Info.plist localized for app name and permission descriptions (Face ID usage string, notification prompt).

### 13.3 Localization Scope

| Category | Examples |
|---|---|
| **UI Labels & Navigation** | Tab names ("Vault" / "保险柜"), section headers, button text |
| **Form Fields & Placeholders** | "Card Number" / "卡号", "Cardholder Name" / "持卡人姓名" |
| **Status Badges** | "Due in 3 days" / "3天后到期", "Paid" / "已还款", "Overdue" / "已逾期" |
| **Security Messaging** | "All cards encrypted" / "所有卡片已加密" |
| **Notifications** | Payment reminders, expiration alerts, security event descriptions |
| **Onboarding** | Welcome screen, biometric setup prompt, first-card prompt |
| **Error Messages** | Validation errors (Luhn failure, missing fields), auth failures |
| **Accessibility Labels** | VoiceOver descriptions for all interactive elements |
| **App Store Metadata** | App name, subtitle, description, keywords, screenshots |

### 13.4 Localization Guidelines

| Rule | Detail |
|---|---|
| **No string concatenation** | Use parameterized strings (`"Due in %d days"` / `"%d天后到期"`) to respect grammar differences. |
| **Date & Currency Formatting** | Use `DateFormatter` / `NumberFormatter` — never hardcode formats. Dates: `en` = "Jun 18", `zh-Hans` = "6月18日". |
| **Layout Flexibility** | Chinese text is typically shorter than English. Ensure UI does not depend on fixed string widths. Test both languages at all Dynamic Type sizes. |
| **Font Support** | Manrope and Plus Jakarta Sans support Latin characters. For Simplified Chinese, fall back to SF Pro. |
| **Pluralization** | English requires singular/plural forms. Chinese does not inflect — use a single form. Handle via Xcode String Catalog plural APIs. |

---

## 14. Cross-Platform Compatibility

### 14.1 Export/Import with Qt Version

CardVault on Apple platforms can export/import a `.vault` file that is compatible with the Qt version (Windows/Linux). This enables users to transfer their card data between platforms.

**Export format:**
- AES-256-GCM encrypted archive
- Key derived from a user-provided passphrase via Argon2id (memory = 64 MB, iterations = 3, parallelism = 4)
- Contains: all card metadata + encrypted card numbers and CVVs
- File extension: `.vault`

**Export flow:**
1. User taps "Export Data" in Profile > Settings
2. User provides an export passphrase (separate from device biometrics)
3. App generates encrypted `.vault` file
4. Share sheet presented (AirDrop, Files, email, etc.)

**Import flow:**
1. User opens `.vault` file (via Files app or share sheet)
2. App prompts for the export passphrase
3. Data is decrypted, card numbers/CVVs stored in Keychain, metadata stored in SwiftData

---

## 15. Future Considerations (Out of Scope for v1.0)

| Feature | Priority | Notes |
|---|---|---|
| Apple Watch companion | Medium | Wrist-based payment reminders via WidgetKit |
| Shared cards (Family) | Medium | Encrypted sharing via CloudKit Shared Zones |
| Reward points tracking | Low | Track points/cashback per card |
| Spending categorization (auto) | Medium | Automatic categorization via ML (Create ML) |
| Bill amount tracking | Medium | Record actual statement amounts per cycle |
| Siri Shortcuts | Low | "Hey Siri, when is my Chase card due?" |
| Import from bank apps | Low | CSV/PDF statement parsing |
| Risk Management Concierge | Medium | Premium advisory feature |
| Vault Composition Analytics | Low | Asset class breakdown |

---

## 16. Design Screens Reference (Stitch)

The following screens are available in the Stitch project (`projects/16203673754999454503`):

| Screen | Device | Theme | Screen ID |
|---|---|---|---|
| Main: Card Stack | Mobile | Dark | `79ffe2be5d1c43b48041f28201c8e27d` |
| Main: Card Stack | Mobile | Light | `e7e79725014c406894d4876dc9cec431` |
| Card Detail Sheet | Mobile | Dark | `f078d990e7cb4c4a902a46040ead8dc1` |
| Manage: Card List | Mobile | Dark | `48ee40a066e44d1ba77a265cabcbe055` |
| Manage: Card List | Mobile | Light | `94bb10dc2312485983dadaf0211d9e19` |
| Manage: Add Card Flow | Mobile | Dark | `a41dcec53eea41f59f88c1e95496ed23` |
| Manage: Add Card (Network Selector) | Mobile | Dark | `8cb8b916ff1c46cd98b1db5ba75b8a37` |
| Profile: Statistics | Mobile | Dark | `624ecb2268ba4ddca3e6207af11ed1f7` |
| Profile: Statistics | Mobile | Light | `3b001574ed60459b81d615b2ded39a92` |
| Main: Dashboard | Desktop | Light | `0efffef26ffb4adf87fa474720c9a661` |
| Main: Dashboard | Desktop | Dark | `aca80b8bf9a54998a2c30aa12288026a` |
| Manage: Card List | Desktop | Light | `9f3c3331d05446d88b29bb9b02d0929f` |
| Manage: Card List | Desktop | Dark | `8f81aa1a922e43db8412a24100737468` |
| Profile: Statistics | Desktop | Light | `011071cfe7b6441d81ae436392d77a1c` |
| Profile: Statistics | Desktop | Dark | `9233d489b53b4361b62053b2688aeb16` |

---

## Appendix A: Glossary

| Term | Definition |
|---|---|
| BIN | Bank Identification Number — the first 6-8 digits of a card number that identify the issuer |
| CVV | Card Verification Value — 3 or 4 digit security code |
| Billing Date | The date the card issuer generates the monthly statement |
| Payment Due Date | The deadline for paying the statement balance to avoid late fees |
| Luhn Algorithm | Checksum formula used to validate card numbers |
| Liquid Glass | Apple's design language featuring translucent, depth-aware UI materials |
| SwiftData | Apple's modern persistence framework built on Core Data, with native SwiftUI integration |
| Keychain Services | Apple's secure storage for passwords, keys, and sensitive data — hardware-backed by Secure Enclave |
| CloudKit | Apple's cloud database service — private database for per-user encrypted sync |
| LAContext | LocalAuthentication framework class for Face ID / Touch ID authentication |
| Vault Integrity Score | Aggregate score (0-100) measuring the security posture of the user's card vault |
| Health Score | Financial health rating derived from credit utilization, payment history, and card diversity |
| Security Radar | Real-time feed of security-relevant events (logins, key rotations, CVV attempts) |

---

*End of document.*
