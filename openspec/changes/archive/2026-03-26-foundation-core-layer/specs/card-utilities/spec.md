## ADDED Requirements

### Requirement: Luhn algorithm validation
The system SHALL validate card numbers using the Luhn algorithm (ISO/IEC 7812-1). The validator SHALL accept a string input, strip spaces/dashes, and return a boolean indicating validity.

#### Scenario: Valid card number
- **WHEN** `LuhnValidator.isValid("4111 1111 1111 1111")` is called
- **THEN** it SHALL return `true`

#### Scenario: Invalid card number
- **WHEN** `LuhnValidator.isValid("4111 1111 1111 1112")` is called
- **THEN** it SHALL return `false`

#### Scenario: Non-numeric input
- **WHEN** `LuhnValidator.isValid("abcd efgh")` is called
- **THEN** it SHALL return `false`

#### Scenario: Empty input
- **WHEN** `LuhnValidator.isValid("")` is called
- **THEN** it SHALL return `false`

### Requirement: Card network detection from BIN
The system SHALL detect the card network from the first 6-8 digits (BIN) of a card number. Detection rules:

| Network | BIN Pattern |
|---------|-------------|
| Visa | Starts with 4 |
| Mastercard | Starts with 51-55 or 2221-2720 |
| Amex | Starts with 34 or 37 |
| UnionPay | Starts with 62 or 81 |
| JCB | Starts with 3528-3589 |
| Discover | Starts with 6011, 622126-622925, 644-649, or 65 |

#### Scenario: Visa detection
- **WHEN** `CardNetworkDetector.detect("4111111111111111")` is called
- **THEN** it SHALL return `.visa`

#### Scenario: Mastercard detection
- **WHEN** `CardNetworkDetector.detect("5111111111111118")` is called
- **THEN** it SHALL return `.mastercard`

#### Scenario: Amex detection
- **WHEN** `CardNetworkDetector.detect("371449635398431")` is called
- **THEN** it SHALL return `.amex`

#### Scenario: Unknown network
- **WHEN** `CardNetworkDetector.detect("9999999999999999")` is called
- **THEN** it SHALL return `nil`

#### Scenario: Partial input during typing
- **WHEN** `CardNetworkDetector.detect("41")` is called (only 2 digits entered)
- **THEN** it SHALL return `.visa` (best match from available digits)

### Requirement: Clipboard auto-clear
The system SHALL clear the system clipboard after a configurable timeout (default 30 seconds) when sensitive card data is copied. The `ClipboardManager` SHALL provide `copyWithAutoClear(_ text: String, clearAfter: TimeInterval)`.

#### Scenario: Copy and auto-clear
- **WHEN** `ClipboardManager.copyWithAutoClear("4111111111111111", clearAfter: 30)` is called
- **THEN** the text SHALL be placed on the system clipboard AND automatically removed after 30 seconds

#### Scenario: New copy cancels previous timer
- **WHEN** `copyWithAutoClear` is called while a previous auto-clear timer is active
- **THEN** the previous timer SHALL be cancelled and a new timer SHALL start for the new content

#### Scenario: App termination before clear
- **WHEN** the app is terminated before the auto-clear timer fires
- **THEN** the clipboard content SHALL remain (best-effort clearing, not guaranteed on termination)
