## ADDED Requirements

### Requirement: Complete Aether Glass color token set
The system SHALL define all 47 color tokens from the Aether Glass design system (Stitch project 16203673754999454503) as Asset Catalog colorsets with both dark and light mode variants. Each token SHALL be accessible as a `Color` extension in SwiftUI.

#### Scenario: All tokens available in dark mode
- **WHEN** the app is in dark mode
- **THEN** all 47 color tokens SHALL resolve to their dark mode hex values as defined in the Stitch design system

#### Scenario: All tokens available in light mode
- **WHEN** the app is in light mode
- **THEN** all 47 color tokens SHALL resolve to their light mode hex values as defined in the Stitch design system

### Requirement: New surface tokens
The system SHALL add `surfaceContainerLowest` (#0e0e0e dark / #ffffff light), `surfaceDim` (#131313 dark / #d8dadc light), `surfaceTint` (#aac7ff dark / #005bc1 light), and `surfaceVariant` (#353534 dark / #e0e3e5 light) as colorsets and Color extensions.

#### Scenario: Surface lowest for pop elements
- **WHEN** `Color.surfaceContainerLowest` is used on a card in dark mode
- **THEN** it SHALL render as #0e0e0e, creating depth below the base surface

### Requirement: Semantic on-* color tokens
The system SHALL add all semantic foreground tokens: `onPrimary`, `onPrimaryContainer`, `onPrimaryFixed`, `onPrimaryFixedVariant`, `onSecondary`, `onSecondaryContainer`, `onSecondaryFixed`, `onSecondaryFixedVariant`, `onTertiary`, `onTertiaryContainer`, `onTertiaryFixed`, `onTertiaryFixedVariant`, `onError`, `onErrorContainer`, `onBackground`.

#### Scenario: Readable text on primary background
- **WHEN** text is placed on a `primaryContainer` background in dark mode
- **THEN** using `Color.onPrimaryContainer` (#002957) SHALL provide readable contrast

### Requirement: Fixed and dim color variants
The system SHALL add `primaryFixed`, `primaryFixedDim`, `secondaryFixed`, `secondaryFixedDim`, `tertiaryFixed`, `tertiaryFixedDim` tokens that remain consistent across color schemes for cross-theme elements.

#### Scenario: Fixed color usage
- **WHEN** `Color.primaryFixed` is used
- **THEN** it SHALL render as #d6e3ff (dark) / #d8e2ff (light)

### Requirement: Inverse color tokens
The system SHALL add `inversePrimary`, `inverseSurface`, `inverseOnSurface` for elements that need inverted contrast (e.g., snackbars, toasts).

#### Scenario: Inverse surface in dark mode
- **WHEN** `Color.inverseSurface` is used in dark mode
- **THEN** it SHALL render as #e5e2e1 (a light color on dark background)

### Requirement: Outline tokens
The system SHALL add `outline` (#8b91a0 dark / #717786 light) and `outlineVariant` (#414754 dark / #c1c6d7 light) for ghost borders and subtle edges per the No-Line Rule fallback.

#### Scenario: Ghost border accessibility fallback
- **WHEN** a container edge needs definition for accessibility
- **THEN** `Color.outlineVariant` at 15% opacity SHALL be used instead of a solid border

### Requirement: Secondary and error container tokens
The system SHALL add `secondaryContainer`, `errorContainer`, and `background` as colorsets.

#### Scenario: Error container glow
- **WHEN** a critical error state is displayed
- **THEN** `Color.errorContainer` SHALL be used as a soft background glow, not a solid fill
