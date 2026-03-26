## ADDED Requirements

### Requirement: Dark mode color tokens
The system SHALL define color tokens as `Color` extensions matching the PRD's dark mode palette: `surface` (#131313), `surfaceContainerLow` (#1c1b1b), `surfaceContainer` (#201f1f), `surfaceContainerHigh` (#2a2a2a), `surfaceContainerHighest` (#353534), `surfaceBright` (#393939), `primaryToken` (#aac7ff), `primaryContainer` (#3e90ff), `secondaryToken` (#c6c6cb), `tertiaryToken` (#c2c1ff), `tertiaryContainer` (#8382ff), `errorToken` (#ffb4ab), `onSurface` (#e5e2e1), `onSurfaceVariant` (#c0c6d6). These SHALL be defined in the Asset Catalog with both dark and light mode variants.

#### Scenario: Dark mode rendering
- **WHEN** the app is in dark mode
- **THEN** `Color.surface` SHALL resolve to #131313 (never pure black)

#### Scenario: Light mode rendering
- **WHEN** the app is in light mode
- **THEN** `Color.primaryToken` SHALL resolve to #0058bc

### Requirement: Typography scale
The system SHALL define a typography scale as `Font` extensions: `displayLG` (Manrope 3.5rem equivalent), `headlineSM` (Manrope 1.5rem, letter-spacing -0.02em), `titleMD` (Plus Jakarta Sans 1.125rem), `bodyMD` (Plus Jakarta Sans 0.875rem), `labelSM` (Plus Jakarta Sans 0.6875rem), `cardNumber` (SF Mono). If custom fonts are not bundled, the system SHALL fall back to system equivalents (`.largeTitle`, `.headline`, `.title3`, `.body`, `.caption`, `.system(.body, design: .monospaced)`).

#### Scenario: Font availability with custom fonts
- **WHEN** Manrope and Plus Jakarta Sans font files are bundled in the app
- **THEN** the typography extensions SHALL use `Font.custom("Manrope", size:)` with appropriate sizes

#### Scenario: Font fallback without custom fonts
- **WHEN** custom font files are not available
- **THEN** the typography extensions SHALL fall back to system font equivalents

### Requirement: Liquid Glass view modifier
The system SHALL provide a `.liquidGlass()` view modifier that applies `.glassEffect()` material with appropriate styling for the Liquid Glass design language. On pre-iOS 26 systems, it SHALL fall back to `.ultraThinMaterial`.

#### Scenario: Glass effect application
- **WHEN** `.liquidGlass()` is applied to a view
- **THEN** the view SHALL have a frosted glass appearance consistent with the design system

### Requirement: Card shape modifier
The system SHALL provide a `.cardShape()` modifier that clips the view to `RoundedRectangle(cornerRadius: 24)` and applies the standard card styling (no borders, gradient base).

#### Scenario: Card rendering
- **WHEN** `.cardShape()` is applied to a card view
- **THEN** the view SHALL have 24pt corner radius with no visible borders

### Requirement: No-Line Rule enforcement
The design system SHALL NOT use 1px borders or dividers. Separation SHALL be achieved through background color tier shifts (surface → surfaceContainerLow → surfaceContainer) and Liquid Glass materials.

#### Scenario: Section separation
- **WHEN** two content sections need visual separation
- **THEN** the design SHALL use tonal background shifts (e.g., `surface` to `surfaceContainerLow`) rather than `Divider()` or border strokes

### Requirement: Primary button style
The system SHALL provide a `PrimaryButtonStyle` that uses `primaryToken` background, contrasting text, `Capsule()` clip shape, and `.scaleEffect(1.02)` press animation.

#### Scenario: Button rendering
- **WHEN** a button uses `.buttonStyle(PrimaryButtonStyle())`
- **THEN** it SHALL render as a capsule with `primaryToken` background and scale animation on press

### Requirement: Spring animation constants
The system SHALL define animation constants: card touch spring `Animation.spring(response: 0.4, dampingFraction: 0.7)` and card translate distance of 20pt. These SHALL be accessible as static properties.

#### Scenario: Animation constant usage
- **WHEN** a card is tapped in the stack
- **THEN** it SHALL animate upward 20pt using the defined spring animation parameters
