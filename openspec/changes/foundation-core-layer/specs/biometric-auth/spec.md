## ADDED Requirements

### Requirement: Mandatory biometric authentication on app launch
The system SHALL require biometric authentication (Face ID / Touch ID) every time the app launches or returns to foreground. Authentication SHALL use `LAContext.evaluatePolicy(.deviceOwnerAuthentication)` which includes automatic device passcode fallback.

#### Scenario: Successful biometric auth
- **WHEN** the app launches and the user authenticates successfully via Face ID or Touch ID
- **THEN** `AppState.isAuthenticated` SHALL be set to `true` and the main UI SHALL be displayed

#### Scenario: Biometric failure with passcode fallback
- **WHEN** biometric authentication fails 3 times
- **THEN** the system SHALL automatically present device passcode input as fallback (handled by `.deviceOwnerAuthentication` policy)

#### Scenario: All authentication fails
- **WHEN** both biometric and passcode authentication fail
- **THEN** `AppState.isAuthenticated` SHALL remain `false` and the app SHALL show the locked screen with a retry option

### Requirement: Biometric cannot be disabled
The system SHALL NOT provide any UI toggle or setting to disable biometric authentication. The biometric lock setting in Profile SHALL be visible but permanently enabled.

#### Scenario: Security toggles display
- **WHEN** the user views security settings
- **THEN** the biometric toggle SHALL appear as "On" and SHALL NOT be interactive (disabled state with explanation)

### Requirement: Auto-lock on background
The system SHALL set `AppState.isAuthenticated` to `false` when the app enters background, requiring re-authentication on return to foreground.

#### Scenario: App backgrounded and resumed
- **WHEN** the app moves to background and then returns to foreground
- **THEN** the biometric authentication prompt SHALL be presented before showing any content

### Requirement: BiometricService availability check
The system SHALL provide a method to check whether biometric authentication is available on the device, returning the type (Face ID, Touch ID, or none).

#### Scenario: Face ID available
- **WHEN** `BiometricService.biometricType()` is called on a Face ID device
- **THEN** it SHALL return `.faceID`

#### Scenario: No biometrics available
- **WHEN** `BiometricService.biometricType()` is called on a device without biometric hardware
- **THEN** it SHALL return `.none` and the app SHALL fall back to device passcode only

### Requirement: Preview mode bypass
The system SHALL provide a `previewMode` flag on `AppState` that bypasses authentication in `#if DEBUG` SwiftUI preview contexts only. This flag SHALL NOT be accessible in release builds.

#### Scenario: SwiftUI preview rendering
- **WHEN** a view is rendered in a SwiftUI preview with `AppState(previewMode: true)`
- **THEN** the view SHALL display without requiring biometric authentication
