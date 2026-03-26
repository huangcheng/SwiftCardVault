## Why

Users currently have no way to add cards to the vault. The "Add New Card" tile on the dashboard and the "Add Card" button in the empty state are placeholders. The add card flow is the critical path to populating the vault — without it, the app has no utility beyond viewing mock data.

## What Changes

- **iOS**: Present a bottom sheet ("New Asset") with fields for card number, network selector pills (AMEX/VISA/MASTER/UNIO/JCB), cardholder name, expiry date, security code (CVV), and a "Continue to Terms →" CTA. Auto-detect network from BIN. Save card number + CVV to Keychain, metadata to SwiftData.
- **macOS**: Present a "Register New Card" view with two-column layout — left column has network selector icons + card information form, right column has live card preview + billing configuration (billing date, due date, credit limit) + "Finalize Registration →" CTA.
- Both platforms validate via Luhn algorithm and require all fields before submission.
- Wire up the "Add New Card" tile in VaultView and the empty state button to present the add card flow.
- Create a `SecurityEvent` (.cardAdded) when a card is successfully saved.

## Capabilities

### New Capabilities
- `add-card-form`: Multi-field card entry form with network selector, Luhn validation, Keychain storage for secrets, SwiftData persistence for metadata, and live card preview (macOS)

### Modified Capabilities

## Impact

- **Features/Manage/**: New `AddCardView.swift` + supporting views, replacing `ManagePlaceholderView` usage in the add card flow
- **Features/Vault/**: Wire AddCardTile and VaultEmptyStateView to present the add card sheet/view
- **Core/Services/KeychainService**: Already implemented, will be called to store card number + CVV
- **Core/Utilities/**: LuhnValidator and CardNetworkDetector already implemented, will be used for validation
- **Localization**: ~20 new strings for form labels, placeholders, validation errors
