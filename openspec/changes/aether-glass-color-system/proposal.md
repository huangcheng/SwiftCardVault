## Why

The current Asset Catalog has 14 color tokens from the PRD. The actual Aether Glass design system in Stitch project `16203673754999454503` defines 40+ tokens per mode (light & dark), including surface variants, semantic on-* colors, inverse colors, outline tokens, fixed/dim variants, and status colors. We need to align the codebase with the canonical Stitch design system to ensure pixel-accurate implementation of all screens.

## What Changes

- Replace the existing 14 colorsets with the complete 40+ token set from the Aether Glass Stitch design system
- Add missing tokens: `surfaceContainerLowest`, `surfaceDim`, `surfaceTint`, `surfaceVariant`, `background`, `primaryFixed`, `primaryFixedDim`, `secondaryContainer`, `secondaryFixed`, `secondaryFixedDim`, `tertiaryFixed`, `tertiaryFixedDim`, `errorContainer`, `outline`, `outlineVariant`, `inversePrimary`, `inverseSurface`, `inverseOnSurface`, and all `on*` semantic colors
- Update `Color` extensions in `DesignTokens.swift` to expose all new tokens
- Update existing color values where the Stitch design system differs from initial PRD estimates

## Capabilities

### New Capabilities
- `color-tokens-full`: Complete Aether Glass color token set (40+ tokens) for both light and dark modes, sourced from Stitch project 16203673754999454503

### Modified Capabilities

## Impact

- **Asset Catalog**: ~30 new colorsets added, existing 14 updated to match exact Stitch values
- **DesignTokens.swift**: New `Color` extensions for all additional tokens
- **No breaking changes**: Existing token names preserved, only values updated and new tokens added
