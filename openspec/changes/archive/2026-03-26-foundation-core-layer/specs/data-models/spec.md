## ADDED Requirements

### Requirement: CreditCard SwiftData model
The system SHALL define a `CreditCard` SwiftData `@Model` class with all metadata properties having default values for CloudKit compatibility. Properties: `id` (UUID), `nickname` (String), `cardholderName` (String), `lastFourDigits` (String), `cardNetwork` (CardNetwork enum), `cardCategory` (String), `issuerName` (String), `expirationMonth` (Int), `expirationYear` (Int), `billingDate` (Int), `paymentDueDate` (Int), `creditLimit` (Decimal?), `currentBalance` (Decimal?), `cardColor` (String hex), `displayOrder` (Int), `isPaidThisCycle` (Bool), `isLocked` (Bool), `createdAt` (Date), `updatedAt` (Date). The model SHALL NOT store full card numbers or CVVs — those are Keychain-only.

#### Scenario: Model instantiation with defaults
- **WHEN** a new `CreditCard` is created with no arguments
- **THEN** all properties SHALL have sensible defaults (empty strings, current date, `.visa` network, `false` for booleans, `0` for integers)

#### Scenario: CloudKit compatibility
- **WHEN** the model is included in a SwiftData `ModelContainer` with CloudKit sync
- **THEN** the schema SHALL be valid with no migration issues because all properties have defaults

### Requirement: CardNetwork enumeration
The system SHALL define a `CardNetwork` enum with cases: `visa`, `mastercard`, `amex`, `unionpay`, `jcb`, `discover`. The enum SHALL conform to `String`, `Codable`, and `CaseIterable`. Each case SHALL provide a `displayName` (localized) and an `sfSymbolName` for UI rendering.

#### Scenario: All supported networks represented
- **WHEN** iterating `CardNetwork.allCases`
- **THEN** all 6 networks (Visa, Mastercard, Amex, UnionPay, JCB, Discover) SHALL be present

#### Scenario: Display name localization
- **WHEN** accessing `CardNetwork.visa.displayName`
- **THEN** the system SHALL return a localized string ("Visa" in en, appropriate translation in zh-Hans)

### Requirement: SecurityEvent SwiftData model
The system SHALL define a `SecurityEvent` `@Model` class with properties: `id` (UUID), `eventType` (SecurityEventType enum), `eventDescription` (String), `location` (String?), `riskLevel` (RiskLevel enum), `timestamp` (Date). All properties SHALL have defaults.

#### Scenario: Security event creation
- **WHEN** a new `SecurityEvent` is created with a specific event type and description
- **THEN** it SHALL store the event with the current timestamp and default risk level of `.low`

### Requirement: SecurityEventType enumeration
The system SHALL define a `SecurityEventType` enum with cases: `loginDetected`, `encryptionUpdated`, `biometricChanged`, `cardAdded`, `cardDeleted`, `cardLocked`, `cardUnlocked`, `exportPerformed`, `importPerformed`. The enum SHALL conform to `String` and `Codable`.

#### Scenario: Event type coverage
- **WHEN** any security-relevant action occurs in the app
- **THEN** there SHALL be a matching `SecurityEventType` case to categorize it

### Requirement: RiskLevel enumeration
The system SHALL define a `RiskLevel` enum with cases: `low`, `medium`, `high`. The enum SHALL conform to `String`, `Codable`, and `Comparable`.

#### Scenario: Risk level ordering
- **WHEN** comparing risk levels
- **THEN** `.low < .medium < .high` SHALL hold true

### Requirement: SpendingCategory SwiftData model
The system SHALL define a `SpendingCategory` `@Model` class with properties: `id` (UUID), `name` (String), `amount` (Decimal), `percentage` (Double), `transactionCount` (Int), `period` (Date). All properties SHALL have defaults.

#### Scenario: Category instantiation
- **WHEN** a new `SpendingCategory` is created for "Dining & Travel"
- **THEN** it SHALL store the name, amount, percentage, and transaction count with the specified period
