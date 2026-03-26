## ADDED Requirements

### Requirement: Vault header with branding
The iOS vault dashboard SHALL display a header with a lock shield icon (`lock.shield.fill`) in `primaryToken` color, the title "The Vault" in `headlineSM` font, and a settings gear icon (`gearshape`) on the trailing edge. The header SHALL use `onSurface` text color on `surface` background.

#### Scenario: Header rendering
- **WHEN** the vault tab is displayed on iOS
- **THEN** the header SHALL show the lock icon, "The Vault" title, and settings gear

### Requirement: Total wealth metric display
The vault SHALL display the aggregate balance across all cards as a large formatted currency number using `displayLG` font. Below the number, a growth indicator badge SHALL show a percentage (e.g., "+2.4% this month") in a capsule with `primaryContainer` background. A "Updated Xm ago" freshness timestamp SHALL appear below in `labelSM`.

#### Scenario: Total wealth with cards
- **WHEN** the user has cards with balances ($15,000 + $27,890.12)
- **THEN** the total wealth SHALL display "$42,890.12" in `displayLG` font

#### Scenario: Total wealth empty
- **WHEN** no cards exist
- **THEN** the total wealth SHALL display "$0.00"

### Requirement: Stacked card display with overlap
The vault SHALL display credit cards in a vertically stacked layout with -160pt overlap between cards, sorted by `displayOrder`. Each card tile SHALL show: card network badge (SF Symbol), nickname, issuer name, masked last 4 digits in `cardNumber` font (SF Mono), expiration date (MM/YY), status badge ("Due in N days" / "Paid" / "Overdue"), and current balance. Cards SHALL use `cardShape()` modifier (24pt corner radius) with gradient backgrounds derived from the card's `cardColor` property.

#### Scenario: Card stack with 3 cards
- **WHEN** 3 cards exist in the vault
- **THEN** they SHALL be displayed overlapping with -160pt vertical offset, top card fully visible, lower cards partially visible

#### Scenario: Card touch animation
- **WHEN** the user taps a card in the stack
- **THEN** the card SHALL animate upward 20pt using `.spring(response: 0.4, dampingFraction: 0.7)`

### Requirement: Card status badge
Each card SHALL display a status badge based on billing cycle: "Due in N days" (warning, `tertiaryContainer` background) when payment is upcoming, "Paid" (success, `primaryToken` tint) when `isPaidThisCycle` is true, "Overdue" (error, `errorToken` tint) when due date has passed and not paid.

#### Scenario: Due in 3 days
- **WHEN** a card's `paymentDueDate` is 3 days from now and `isPaidThisCycle` is false
- **THEN** the status badge SHALL display "Due in 3 days" with warning styling

#### Scenario: Paid status
- **WHEN** `isPaidThisCycle` is true
- **THEN** the status badge SHALL display "Paid" with success styling

### Requirement: Security radar section
The vault SHALL display a "Recent Security Events" section showing the latest security events from `SecurityEvent` model, sorted by timestamp descending, limited to 5 items. Each event SHALL show an icon (based on event type), description text, location (if available), and relative timestamp. The section SHALL use `surfaceContainerLow` background.

#### Scenario: Security events display
- **WHEN** security events exist (e.g., "Encryption Updated", "New Login Detected")
- **THEN** they SHALL appear in chronological order with appropriate icons and timestamps

#### Scenario: No security events
- **WHEN** no security events exist
- **THEN** a "No recent events" placeholder message SHALL be displayed

### Requirement: Empty vault state
When no cards exist, the vault SHALL display a centered layout with: a wallet icon (`wallet.bifold`) in `primaryToken`, "Your vault is empty" title in `headlineSM`, "Add your first card to get started" subtitle in `bodyMD`, and an "Add Card" primary CTA button using `PrimaryButtonStyle`.

#### Scenario: First launch empty state
- **WHEN** the user has no cards in the vault
- **THEN** the empty state with add card prompt SHALL be displayed instead of the card stack

### Requirement: Scrollable content
The entire vault dashboard content SHALL be wrapped in a `ScrollView` to accommodate variable content height (multiple cards, security events).

#### Scenario: Scroll behavior
- **WHEN** content exceeds the screen height
- **THEN** the user SHALL be able to scroll vertically through all vault sections
