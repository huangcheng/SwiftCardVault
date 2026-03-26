## Context

Design comps fetched from Stitch project `16203673754999454503`:
- Desktop Light: "Add Card (Desktop - Light)" — screen `7fbb1c94e22f4daeb5dd7b0fd335f0e8`
- Mobile Dark: "Manage: Add Card (Network Selector)" — screen `8cb8b916ff1c46cd98b1db5ba75b8a37`

The desktop comp shows a single-page two-column form. The mobile comp shows a bottom sheet. Both share the same data entry fields but differ in layout and presentation.

## Goals / Non-Goals

**Goals:**
- Implement the add card form matching both Stitch comps
- Auto-detect card network from BIN as user types card number
- Validate card number via Luhn algorithm before allowing submission
- Store card number and CVV securely in Keychain
- Store card metadata in SwiftData
- Create a SecurityEvent on successful card addition
- Wire the add card flow to the vault dashboard's add card tile and empty state
- Live card preview on macOS that updates as user types

**Non-Goals:**
- Camera OCR scanning (separate change)
- Multi-step flow (PRD has 3 steps, but Stitch comps show single-step — follow Stitch)
- Edit card flow (separate change)
- Billing cycle step 2 / confirmation step 3 (not in Stitch light comps)

## Decisions

### 1. Single-Step Form (Following Stitch Comps)

The PRD defines a 3-step flow (New Asset → Financial Cycles → Ready for Encryption), but the Stitch desktop comp shows everything on a single page. We follow the Stitch comp: one form, one submit.

### 2. Presentation Style

- **iOS**: `.sheet` presentation (bottom sheet) matching the mobile comp's drag handle and overlay style
- **macOS**: `NavigationLink` or full content replacement in the detail area, matching the desktop comp's full-page form layout

### 3. Form State Management

A single `@Observable` class `AddCardFormState` holds all form fields, validation state, and the auto-detected network. This is shared between the form inputs and the live card preview.

### 4. Card Number Formatting

As the user types, the card number is auto-formatted with spaces every 4 digits (e.g., "4111 1111 1111 1111"). The raw digits are extracted for validation and storage.

### 5. Network Selector

Both comps show network selector buttons/pills. On typing a card number, the network auto-selects via `CardNetworkDetector`. User can also manually override the selection.

### 6. Desktop Layout (from Stitch comp)

```
"Register New Card" heading + subtitle    |  "← Back to Cards" link
                                          |
┌─ SELECT NETWORK ─────────────────┐      ┌─ Card Preview ──────────────┐
│ [VISA] [MASTERCARD] [AMEX] [DISC]│      │  Live preview matching      │
└──────────────────────────────────┘      │  CardStackItem appearance   │
┌─ CARD INFORMATION ───────────────┐      └─────────────────────────────┘
│ Cardholder Name: [___________]   │      ┌─ BILLING CONFIGURATION ─────┐
│ Card Number:     [___________ 🔒]│      │ Billing Date: [1st of Month]│
│ Expiry Date: [MM/YY]  CVV: [___]│      │ Due Date:     [10 Days Later]│
└──────────────────────────────────┘      │ Credit Limit: [$ 5,000]     │
                                          └─────────────────────────────┘
                                          [Finalize Registration →]
```

### 7. Mobile Layout (from Stitch comp)

```
── Sheet with drag handle ──
"New Asset"
"Enter your physical card credentials..."

CARD NUMBER
[0000 0000 0000 0000 📇]

CARD NETWORK
[AMEX] [VISA✓] [MASTER] [UNIO]

CARDHOLDER NAME
[NAME ON CARD]

EXPIRY DATE        SECURITY CODE
[MM/YY]            [•••]

[Continue to Terms →]
🛡️
```

## Risks / Trade-offs

- **[Risk] Keychain access fails in Simulator** → Handle gracefully with error alert; card metadata still saved to SwiftData
- **[Trade-off] Single-step vs PRD's 3-step** → Following Stitch comps which are the authoritative design source. All PRD fields are still captured in one step.
