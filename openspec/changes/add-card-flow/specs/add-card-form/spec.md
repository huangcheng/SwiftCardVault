## ADDED Requirements

### Requirement: Card number input with auto-formatting
The form SHALL provide a card number text field that auto-formats input with spaces every 4 digits as the user types. The field SHALL display a card/lock icon on the trailing edge. Input SHALL be restricted to numeric characters only. Maximum 19 digits (16-19 raw digits depending on network).

#### Scenario: Auto-formatting while typing
- **WHEN** the user types "4111111111111111"
- **THEN** the field SHALL display "4111 1111 1111 1111"

#### Scenario: Non-numeric input rejected
- **WHEN** the user types alphabetic characters
- **THEN** they SHALL be silently stripped from the input

### Requirement: Card network selector with auto-detection
The form SHALL display network selector buttons/pills for Visa, Mastercard, Amex, UnionPay, JCB, and Discover. As the user types a card number, the network SHALL auto-detect via `CardNetworkDetector` and the corresponding button SHALL be selected. The user SHALL be able to manually override the auto-detection.

#### Scenario: Auto-detection from BIN
- **WHEN** the user types "4111" in the card number field
- **THEN** the Visa network button SHALL automatically become selected

#### Scenario: Manual override
- **WHEN** the user taps the Mastercard button while Visa is auto-selected
- **THEN** Mastercard SHALL become the selected network

### Requirement: Cardholder name input
The form SHALL provide a text field for the cardholder name with placeholder "e.g. JAMES MORRISON" (desktop) or "NAME ON CARD" (mobile). The field SHALL auto-capitalize input to uppercase.

#### Scenario: Name entry
- **WHEN** the user types "james morrison"
- **THEN** the field SHALL display "JAMES MORRISON"

### Requirement: Expiry date and CVV fields
The form SHALL provide an expiry date field accepting MM/YY format and a CVV field accepting 3-4 digits. CVV SHALL be masked by default. Both fields SHALL be displayed side by side.

#### Scenario: Expiry date formatting
- **WHEN** the user types "0827"
- **THEN** the field SHALL display "08/27"

#### Scenario: CVV masking
- **WHEN** the user types a CVV
- **THEN** the characters SHALL be masked (shown as dots)

### Requirement: Billing configuration (macOS only)
The macOS form SHALL include billing configuration fields: Billing Date (dropdown with day-of-month options), Due Date (dropdown), and Credit Limit (currency input). These fields appear in the right column below the card preview.

#### Scenario: Billing date selection
- **WHEN** the user selects "1st of Month" for billing date
- **THEN** billingDate SHALL be set to 1

### Requirement: Live card preview (macOS only)
The macOS form SHALL display a live card preview in the right column that updates in real-time as the user fills in the form. The preview SHALL use the same `CardStackItem` visual style showing the selected network logo, entered card number (masked except last 4), cardholder name, and expiry date.

#### Scenario: Live preview updates
- **WHEN** the user types "4242" in the card number field and "ALEX" in the name field
- **THEN** the card preview SHALL show "•••• •••• •••• 4242" and "ALEX" with Visa styling

### Requirement: Luhn validation before submission
The form SHALL validate the card number using `LuhnValidator.isValid()` before allowing submission. If validation fails, an error message SHALL be displayed below the card number field. The submit button SHALL be disabled until all required fields are filled and the card number passes Luhn validation.

#### Scenario: Invalid card number
- **WHEN** the user enters an invalid card number and taps submit
- **THEN** an error message "Invalid card number" SHALL appear and submission SHALL be blocked

#### Scenario: Valid submission
- **WHEN** all fields are valid and Luhn passes
- **THEN** the submit button SHALL be enabled

### Requirement: Save card to Keychain and SwiftData
On submission, the system SHALL: (1) store the full card number via `KeychainService.saveCardNumber()`, (2) store the CVV via `KeychainService.saveCVV()`, (3) create a `CreditCard` SwiftData model with all metadata (last 4 digits extracted from card number, selected network, cardholder name, expiry, billing config), (4) create a `SecurityEvent` with type `.cardAdded`.

#### Scenario: Successful save
- **WHEN** the user taps "Finalize Registration" with valid data
- **THEN** the card SHALL be saved to both Keychain and SwiftData and a cardAdded security event SHALL be created

### Requirement: Dismiss after save
After successful save, the form SHALL dismiss: on iOS the sheet closes, on macOS navigation returns to the vault/manage view.

#### Scenario: Post-save navigation
- **WHEN** the card is successfully saved
- **THEN** the add card form SHALL dismiss and the new card SHALL appear in the vault

### Requirement: Wire add card presentation
The `AddCardTile` on the vault dashboard and the `VaultEmptyStateView` "Add Card" button SHALL present the add card flow when tapped. On iOS this opens a sheet; on macOS this navigates to the form view.

#### Scenario: Tap add card tile
- **WHEN** the user taps the "Add New Card" tile on the vault dashboard
- **THEN** the add card form SHALL be presented
