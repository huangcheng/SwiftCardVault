## 1. Update Existing Colorsets

- [x] 1.1 Verify and update all 14 existing colorsets to match exact Stitch hex values (fix any discrepancies in dark/light mode values)

## 2. Add New Surface Token Colorsets

- [x] 2.1 Add `SurfaceContainerLowest.colorset` (dark #0e0e0e / light #ffffff)
- [x] 2.2 Add `SurfaceDim.colorset` (dark #131313 / light #d8dadc)
- [x] 2.3 Add `SurfaceTint.colorset` (dark #aac7ff / light #005bc1)
- [x] 2.4 Add `SurfaceVariant.colorset` (dark #353534 / light #e0e3e5)
- [x] 2.5 Add `Background.colorset` (dark #131313 / light #f7f9fb)

## 3. Add Primary Semantic Colorsets

- [x] 3.1 Add `OnPrimary.colorset` (dark #003064 / light #ffffff)
- [x] 3.2 Add `OnPrimaryContainer.colorset` (dark #002957 / light #fefcff)
- [x] 3.3 Add `PrimaryFixed.colorset` (dark #d6e3ff / light #d8e2ff)
- [x] 3.4 Add `PrimaryFixedDim.colorset` (dark #aac7ff / light #adc6ff)
- [x] 3.5 Add `OnPrimaryFixed.colorset` (dark #001b3e / light #001a41)
- [x] 3.6 Add `OnPrimaryFixedVariant.colorset` (dark #00468d / light #004493)

## 4. Add Secondary Semantic Colorsets

- [x] 4.1 Add `SecondaryContainer.colorset` (dark #46464b / light #d2e0f9)
- [x] 4.2 Add `SecondaryFixed.colorset` (dark #e3e2e7 / light #d5e3fc)
- [x] 4.3 Add `SecondaryFixedDim.colorset` (dark #c6c6cb / light #b9c7e0)
- [x] 4.4 Add `OnSecondary.colorset` (dark #2f3034 / light #ffffff)
- [x] 4.5 Add `OnSecondaryContainer.colorset` (dark #b5b4ba / light #566378)
- [x] 4.6 Add `OnSecondaryFixed.colorset` (dark #1a1b1f / light #0e1c2e)
- [x] 4.7 Add `OnSecondaryFixedVariant.colorset` (dark #46464b / light #3a485b)

## 5. Add Tertiary Semantic Colorsets

- [x] 5.1 Add `OnTertiary.colorset` (dark #1800a7 / light #ffffff)
- [x] 5.2 Add `OnTertiaryContainer.colorset` (dark #140094 / light #fffbff)
- [x] 5.3 Add `TertiaryFixed.colorset` (dark #e2dfff / light #e3dfff)
- [x] 5.4 Add `TertiaryFixedDim.colorset` (dark #c2c1ff / light #c5c0ff)
- [x] 5.5 Add `OnTertiaryFixed.colorset` (dark #0c006b / light #140067)
- [x] 5.6 Add `OnTertiaryFixedVariant.colorset` (dark #332dbc / light #413996)

## 6. Add Error Semantic Colorsets

- [x] 6.1 Add `ErrorContainer.colorset` (dark #93000a / light #ffdad6)
- [x] 6.2 Add `OnError.colorset` (dark #690005 / light #ffffff)
- [x] 6.3 Add `OnErrorContainer.colorset` (dark #ffdad6 / light #93000a)

## 7. Add Remaining Semantic Colorsets

- [x] 7.1 Add `OnBackground.colorset` (dark #e5e2e1 / light #191c1e)
- [x] 7.2 Add `Outline.colorset` (dark #8b91a0 / light #717786)
- [x] 7.3 Add `OutlineVariant.colorset` (dark #414754 / light #c1c6d7)
- [x] 7.4 Add `InversePrimary.colorset` (dark #005db8 / light #adc6ff)
- [x] 7.5 Add `InverseSurface.colorset` (dark #e5e2e1 / light #2d3133)
- [x] 7.6 Add `InverseOnSurface.colorset` (dark #313030 / light #eff1f3)

## 8. Update DesignTokens.swift

- [x] 8.1 Add `Color` extensions for all new tokens (surfaceContainerLowest, surfaceDim, surfaceTint, surfaceVariant, background, all on* tokens, all *Fixed/*FixedDim tokens, all inverse* tokens, outline, outlineVariant, errorContainer, secondaryContainer)
- [x] 8.2 Verify build compiles successfully with all new color references
