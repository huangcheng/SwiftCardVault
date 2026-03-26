## Context

The Aether Glass design system in Stitch has two variants — Light and Dark — with ~44 named colors each. Our Asset Catalog currently has 14 colorsets under `Colors/` namespace. We need to expand to the full token set while preserving the existing namespace convention.

Source data fetched from Stitch MCP (`list_design_systems` for project `16203673754999454503`).

## Goals / Non-Goals

**Goals:**
- Add all missing color tokens from Stitch as Asset Catalog colorsets with dark/light variants
- Update any existing tokens whose hex values differ from Stitch
- Add corresponding `Color` extensions for SwiftUI usage
- Maintain the `Colors/` namespace in the Asset Catalog

**Non-Goals:**
- Changing typography, spacing, or component styles (separate change)
- Adding gradient definitions (handled in view code, not tokens)
- Modifying ViewModifiers.swift beyond color references

## Decisions

### Token naming: camelCase Swift extensions → PascalCase colorset directories

Stitch uses `snake_case` (e.g., `surface_container_low`). Asset Catalog directories use PascalCase (e.g., `SurfaceContainerLow`). Swift extensions use camelCase (e.g., `Color.surfaceContainerLow`). This mapping is already established in the existing 14 tokens.

### Complete token list from Stitch (Dark / Light hex values)

| Token | Dark | Light |
|-------|------|-------|
| background | #131313 | #f7f9fb |
| surface | #131313 | #f7f9fb |
| surfaceDim | #131313 | #d8dadc |
| surfaceBright | #393939 | #f7f9fb |
| surfaceContainerLowest | #0e0e0e | #ffffff |
| surfaceContainerLow | #1c1b1b | #f2f4f6 |
| surfaceContainer | #201f1f | #eceef0 |
| surfaceContainerHigh | #2a2a2a | #e6e8ea |
| surfaceContainerHighest | #353534 | #e0e3e5 |
| surfaceVariant | #353534 | #e0e3e5 |
| surfaceTint | #aac7ff | #005bc1 |
| primary | #aac7ff | #0058bc |
| primaryContainer | #3e90ff | #0070eb |
| primaryFixed | #d6e3ff | #d8e2ff |
| primaryFixedDim | #aac7ff | #adc6ff |
| onPrimary | #003064 | #ffffff |
| onPrimaryContainer | #002957 | #fefcff |
| onPrimaryFixed | #001b3e | #001a41 |
| onPrimaryFixedVariant | #00468d | #004493 |
| secondary | #c6c6cb | #515f74 |
| secondaryContainer | #46464b | #d2e0f9 |
| secondaryFixed | #e3e2e7 | #d5e3fc |
| secondaryFixedDim | #c6c6cb | #b9c7e0 |
| onSecondary | #2f3034 | #ffffff |
| onSecondaryContainer | #b5b4ba | #566378 |
| onSecondaryFixed | #1a1b1f | #0e1c2e |
| onSecondaryFixedVariant | #46464b | #3a485b |
| tertiary | #c2c1ff | #574fad |
| tertiaryContainer | #8382ff | #7069c7 |
| tertiaryFixed | #e2dfff | #e3dfff |
| tertiaryFixedDim | #c2c1ff | #c5c0ff |
| onTertiary | #1800a7 | #ffffff |
| onTertiaryContainer | #140094 | #fffbff |
| onTertiaryFixed | #0c006b | #140067 |
| onTertiaryFixedVariant | #332dbc | #413996 |
| error | #ffb4ab | #ba1a1a |
| errorContainer | #93000a | #ffdad6 |
| onError | #690005 | #ffffff |
| onErrorContainer | #ffdad6 | #93000a |
| onSurface | #e5e2e1 | #191c1e |
| onSurfaceVariant | #c0c6d6 | #414755 |
| onBackground | #e5e2e1 | #191c1e |
| outline | #8b91a0 | #717786 |
| outlineVariant | #414754 | #c1c6d7 |
| inversePrimary | #005db8 | #adc6ff |
| inverseSurface | #e5e2e1 | #2d3133 |
| inverseOnSurface | #313030 | #eff1f3 |

## Risks / Trade-offs

- **[Risk] Existing views reference old token names** → No risk: all 14 existing token names are preserved. Only values may shift slightly.
- **[Trade-off] 44 colorsets is large** → Necessary for full design system coverage. Asset Catalog handles this efficiently.
