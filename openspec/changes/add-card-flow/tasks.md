## 1. Form State

- [x] 1.1 Create `AddCardFormState` @Observable class: cardNumber (String, raw digits), formattedCardNumber (computed with spaces), detectedNetwork (CardNetwork?), selectedNetwork (CardNetwork), cardholderName (String), expiryMonth (Int), expiryYear (Int), cvv (String), billingDate (Int), paymentDueDate (Int), creditLimit (String), isValid (computed from Luhn + required fields), cardNumberError (String?)
- [x] 1.2 Add auto-formatting logic: strip non-digits, insert space every 4 chars, limit to 19 digits. Add auto-detection: call CardNetworkDetector on cardNumber change, update detectedNetwork and auto-select selectedNetwork

## 2. Shared Form Components

- [x] 2.1 Create `NetworkSelectorView`: horizontal row of network buttons/pills (Visa, Mastercard, Amex, UnionPay, JCB, Discover) with selected state styling (primary background for selected, surfaceContainerLow for unselected). Accepts binding to selectedNetwork
- [x] 2.2 Create `CardNumberField`: TextField with auto-formatting, card icon trailing, numeric keyboard, Luhn validation error display below field
- [x] 2.3 Create `CardFormFieldStyle`: reusable text field style matching Stitch comp — surfaceContainerLow background, rounded corners, label above in small caps tracking

## 3. iOS Add Card Sheet

- [x] 3.1 Create `AddCardSheetView` (iOS): bottom sheet with drag handle, "New Asset" title, subtitle, CardNumberField, NetworkSelectorView, cardholder name field, expiry + CVV side by side, "Continue to Terms →" PrimaryButtonStyle CTA, shield icon at bottom
- [x] 3.2 Implement save logic: on submit, call KeychainService.saveCardNumber + saveCVV, create CreditCard in SwiftData modelContext, create SecurityEvent(.cardAdded), dismiss sheet

## 4. macOS Add Card View

- [x] 4.1 Create `AddCardDesktopView` (macOS): two-column layout — left has "Register New Card" heading + "← Back to Cards" link, SELECT NETWORK section, CARD INFORMATION section (name, number, expiry, cvv)
- [x] 4.2 Create live card preview in right column using CardStackItem with form state data, BILLING CONFIGURATION section (billing date picker, due date picker, credit limit field), "Finalize Registration →" CTA
- [x] 4.3 Implement save logic: same as iOS — Keychain + SwiftData + SecurityEvent, then navigate back

## 5. Wire Up Navigation

- [x] 5.1 Update `AddCardTile` to present add card flow: sheet on iOS, navigation on macOS
- [x] 5.2 Update `VaultEmptyStateView` "Add Card" button to present add card flow
- [x] 5.3 Create unified `AddCardView` with `#if os(iOS)` / `#if os(macOS)` routing to the appropriate platform view

## 6. Localization

- [x] 6.1 Add all add card strings to Localizable.xcstrings (en + zh-Hans): "Register New Card", "New Asset", "Enter your physical card credentials to encrypt them into the vault.", "SELECT NETWORK", "CARD INFORMATION", "CARD NUMBER", "CARD NETWORK", "Cardholder Name", "Card Number", "Expiry Date", "Security Code", "CVV", "BILLING CONFIGURATION", "Billing Date", "Due Date", "Credit Limit", "Continue to Terms", "Finalize Registration", "Back to Cards", "Invalid card number", "NAME ON CARD", validation messages

## 7. Build & Verify

- [x] 7.1 Build for iOS and macOS, verify no compilation errors
- [x] 7.2 Run existing unit tests to ensure no regressions
