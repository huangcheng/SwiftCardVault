//
//  ViewModifiers.swift
//  CardVault
//

import SwiftUI

// MARK: - Liquid Glass Modifier

struct LiquidGlassModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            content
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: DesignConstants.cardCornerRadius))
        } else {
            content
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
        }
    }
}

extension View {
    func liquidGlass() -> some View {
        modifier(LiquidGlassModifier())
    }
}

// MARK: - Card Shape Modifier

struct CardShapeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
    }
}

extension View {
    func cardShape() -> some View {
        modifier(CardShapeModifier())
    }
}

// MARK: - Primary Button Style

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.titleMD)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 14)
            .background(Color.primaryToken)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? DesignConstants.buttonPressScale : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
