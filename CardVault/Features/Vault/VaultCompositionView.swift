//
//  VaultCompositionView.swift
//  CardVault
//

import SwiftUI

struct VaultCompositionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(String(localized: "Vault Composition"))
                .font(.headlineSM)
                .foregroundStyle(Color.onSurface)

            VStack(spacing: 14) {
                compositionRow(
                    label: String(localized: "FIXED ASSETS"),
                    percentage: 68,
                    color: Color.primaryToken
                )
                compositionRow(
                    label: String(localized: "LIQUID CAPITAL"),
                    percentage: 24,
                    color: Color.secondaryToken
                )
                compositionRow(
                    label: String(localized: "CRYPTO CUSTODY"),
                    percentage: 8,
                    color: Color.tertiaryToken
                )
            }

            // Security Update Card
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Image(systemName: "shield.checkered")
                        .font(.body)
                        .foregroundStyle(Color.tertiaryToken)
                    Text(String(localized: "SECURITY UPDATE"))
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(Color.tertiaryToken)
                        .tracking(1)
                }

                Text(String(localized: "Multi-party computation (MPC) protocols have been upgraded for all business entity cards. No action required."))
                    .font(.labelSM)
                    .foregroundStyle(Color.onSurfaceVariant)
                    .lineSpacing(3)

                Button {
                    // Future implementation
                } label: {
                    Text(String(localized: "READ WHITEPAPER"))
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(Color.tertiaryToken)
                        .tracking(1)
                }
                .buttonStyle(.plain)
            }
            .padding(16)
            .background(Color.surfaceContainerHigh)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(24)
        .background(Color.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
    }

    @ViewBuilder
    private func compositionRow(label: String, percentage: Int, color: Color) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 9, weight: .semibold))
                .foregroundStyle(Color.onSurfaceVariant)
                .tracking(1)

            Spacer()

            Text("\(percentage)%")
                .font(.bodyMD)
                .fontWeight(.semibold)
                .foregroundStyle(Color.onSurface)
        }

        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.surfaceContainerHigh)
                    .frame(height: 6)

                RoundedRectangle(cornerRadius: 3)
                    .fill(color)
                    .frame(width: geometry.size.width * Double(percentage) / 100.0, height: 6)
            }
        }
        .frame(height: 6)
    }
}
