//
//  DesignTokens.swift
//  CardVault
//

import SwiftUI

// MARK: - Color Tokens (Aether Glass Design System)

extension Color {
    // MARK: Surface Hierarchy
    static let background = Color("Colors/Background")
    static let surface = Color("Colors/Surface")
    static let surfaceDim = Color("Colors/SurfaceDim")
    static let surfaceBright = Color("Colors/SurfaceBright")
    static let surfaceContainerLowest = Color("Colors/SurfaceContainerLowest")
    static let surfaceContainerLow = Color("Colors/SurfaceContainerLow")
    static let surfaceContainer = Color("Colors/SurfaceContainer")
    static let surfaceContainerHigh = Color("Colors/SurfaceContainerHigh")
    static let surfaceContainerHighest = Color("Colors/SurfaceContainerHighest")
    static let surfaceVariant = Color("Colors/SurfaceVariant")
    static let surfaceTint = Color("Colors/SurfaceTint")

    // MARK: Primary
    static let primaryToken = Color("Colors/PrimaryToken")
    static let primaryContainer = Color("Colors/PrimaryContainer")
    static let primaryFixed = Color("Colors/PrimaryFixed")
    static let primaryFixedDim = Color("Colors/PrimaryFixedDim")
    static let onPrimary = Color("Colors/OnPrimary")
    static let onPrimaryContainer = Color("Colors/OnPrimaryContainer")
    static let onPrimaryFixed = Color("Colors/OnPrimaryFixed")
    static let onPrimaryFixedVariant = Color("Colors/OnPrimaryFixedVariant")

    // MARK: Secondary
    static let secondaryToken = Color("Colors/SecondaryToken")
    static let secondaryContainer = Color("Colors/SecondaryContainer")
    static let secondaryFixed = Color("Colors/SecondaryFixed")
    static let secondaryFixedDim = Color("Colors/SecondaryFixedDim")
    static let onSecondary = Color("Colors/OnSecondary")
    static let onSecondaryContainer = Color("Colors/OnSecondaryContainer")
    static let onSecondaryFixed = Color("Colors/OnSecondaryFixed")
    static let onSecondaryFixedVariant = Color("Colors/OnSecondaryFixedVariant")

    // MARK: Tertiary
    static let tertiaryToken = Color("Colors/TertiaryToken")
    static let tertiaryContainer = Color("Colors/TertiaryContainer")
    static let tertiaryFixed = Color("Colors/TertiaryFixed")
    static let tertiaryFixedDim = Color("Colors/TertiaryFixedDim")
    static let onTertiary = Color("Colors/OnTertiary")
    static let onTertiaryContainer = Color("Colors/OnTertiaryContainer")
    static let onTertiaryFixed = Color("Colors/OnTertiaryFixed")
    static let onTertiaryFixedVariant = Color("Colors/OnTertiaryFixedVariant")

    // MARK: Error
    static let errorToken = Color("Colors/ErrorToken")
    static let errorContainer = Color("Colors/ErrorContainer")
    static let onError = Color("Colors/OnError")
    static let onErrorContainer = Color("Colors/OnErrorContainer")

    // MARK: On Surface / Background
    static let onSurface = Color("Colors/OnSurface")
    static let onSurfaceVariant = Color("Colors/OnSurfaceVariant")
    static let onBackground = Color("Colors/OnBackground")

    // MARK: Outline
    static let outline = Color("Colors/Outline")
    static let outlineVariant = Color("Colors/OutlineVariant")

    // MARK: Inverse
    static let inversePrimary = Color("Colors/InversePrimary")
    static let inverseSurface = Color("Colors/InverseSurface")
    static let inverseOnSurface = Color("Colors/InverseOnSurface")
}

// MARK: - Typography Scale

extension Font {
    /// Hero balances, "Total Wealth" numbers — Manrope 56pt equivalent
    static let displayLG: Font = .system(size: 56, weight: .bold, design: .rounded)

    /// Section headers — Manrope 24pt, tight letter-spacing
    static let headlineSM: Font = .system(size: 24, weight: .semibold, design: .rounded)

    /// Cardholder names, navigation labels — Plus Jakarta Sans 18pt
    static let titleMD: Font = .system(size: 18, weight: .medium)

    /// General metadata and descriptions — Plus Jakarta Sans 14pt
    static let bodyMD: Font = .system(size: 14, weight: .regular)

    /// Micro-copy (expiry dates, CVV labels) — Plus Jakarta Sans 11pt
    static let labelSM: Font = .system(size: 11, weight: .regular)

    /// Card numbers — SF Mono
    static let cardNumber: Font = .system(size: 18, weight: .medium, design: .monospaced)
}

// MARK: - Animation Constants

struct DesignConstants {
    static let cardCornerRadius: CGFloat = 24
    static let cardOverlap: CGFloat = -160
    static let cardTranslateDistance: CGFloat = 20

    static let cardTouchSpring: Animation = .spring(response: 0.4, dampingFraction: 0.7)
    static let buttonPressScale: CGFloat = 1.02
}
