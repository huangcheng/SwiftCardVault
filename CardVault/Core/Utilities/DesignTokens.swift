//
//  DesignTokens.swift
//  CardVault
//

import SwiftUI

// MARK: - Color Tokens

extension Color {
    static let surface = Color("Colors/Surface")
    static let surfaceContainerLow = Color("Colors/SurfaceContainerLow")
    static let surfaceContainer = Color("Colors/SurfaceContainer")
    static let surfaceContainerHigh = Color("Colors/SurfaceContainerHigh")
    static let surfaceContainerHighest = Color("Colors/SurfaceContainerHighest")
    static let surfaceBright = Color("Colors/SurfaceBright")
    static let primaryToken = Color("Colors/PrimaryToken")
    static let primaryContainer = Color("Colors/PrimaryContainer")
    static let secondaryToken = Color("Colors/SecondaryToken")
    static let tertiaryToken = Color("Colors/TertiaryToken")
    static let tertiaryContainer = Color("Colors/TertiaryContainer")
    static let errorToken = Color("Colors/ErrorToken")
    static let onSurface = Color("Colors/OnSurface")
    static let onSurfaceVariant = Color("Colors/OnSurfaceVariant")
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
