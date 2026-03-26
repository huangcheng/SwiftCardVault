## ADDED Requirements

### Requirement: Store card number in Keychain
The system SHALL store a card's full number in the Keychain using key `card_number_\(cardId)` with access control `kSecAttrAccessibleWhenUnlockedThisDeviceOnly`. The data SHALL be stored as UTF-8 encoded `Data`.

#### Scenario: Successful card number storage
- **WHEN** `KeychainService.saveCardNumber("4111111111111111", for: cardId)` is called
- **THEN** the card number SHALL be stored in Keychain under the correct key with the specified access control

#### Scenario: Update existing card number
- **WHEN** a card number already exists for a given card ID and `saveCardNumber` is called with a new number
- **THEN** the existing entry SHALL be updated (not duplicated)

### Requirement: Store CVV in Keychain
The system SHALL store a card's CVV in the Keychain using key `card_cvv_\(cardId)` with access control `kSecAttrAccessibleWhenUnlockedThisDeviceOnly`.

#### Scenario: Successful CVV storage
- **WHEN** `KeychainService.saveCVV("123", for: cardId)` is called
- **THEN** the CVV SHALL be stored in Keychain under the correct key

### Requirement: Retrieve card number from Keychain
The system SHALL retrieve a card's full number from the Keychain by card ID, returning `String?`.

#### Scenario: Successful retrieval
- **WHEN** `KeychainService.getCardNumber(for: cardId)` is called for an existing entry
- **THEN** the original card number string SHALL be returned

#### Scenario: Missing entry
- **WHEN** `KeychainService.getCardNumber(for: unknownId)` is called for a non-existent entry
- **THEN** `nil` SHALL be returned

### Requirement: Retrieve CVV from Keychain
The system SHALL retrieve a card's CVV from the Keychain by card ID, returning `String?`.

#### Scenario: Successful CVV retrieval
- **WHEN** `KeychainService.getCVV(for: cardId)` is called for an existing entry
- **THEN** the original CVV string SHALL be returned

### Requirement: Delete card secrets from Keychain
The system SHALL delete both card number and CVV entries from Keychain when a card is removed.

#### Scenario: Successful deletion
- **WHEN** `KeychainService.deleteSecrets(for: cardId)` is called
- **THEN** both `card_number_\(cardId)` and `card_cvv_\(cardId)` entries SHALL be removed from Keychain

#### Scenario: Deletion of non-existent entry
- **WHEN** `KeychainService.deleteSecrets(for: unknownId)` is called for entries that don't exist
- **THEN** the operation SHALL complete without error

### Requirement: Card secrets never logged or printed
The system SHALL NOT log, print, or expose card numbers or CVVs in any debug output, console, or crash report. All sensitive data handling SHALL use `Data` or `ContiguousBytes` types where possible.

#### Scenario: Debug logging exclusion
- **WHEN** any KeychainService method executes
- **THEN** no card number or CVV value SHALL appear in any log output
