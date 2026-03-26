//
//  QuickControlsView.swift
//  CardVault
//

import SwiftUI

struct QuickControlsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "Quick Controls"))
                .font(.headlineSM)
                .foregroundStyle(Color.onSurface)

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 10),
                GridItem(.flexible(), spacing: 10)
            ], spacing: 10) {
                controlButton(icon: "lock.fill", label: String(localized: "Lock All"), tint: Color.primaryToken)
                controlButton(icon: "clock.arrow.circlepath", label: String(localized: "History"), tint: Color.onSurfaceVariant)
                controlButton(icon: "checkmark.shield.fill", label: String(localized: "Audit"), tint: Color.primaryToken)
                controlButton(icon: "link", label: String(localized: "Link App"), tint: Color.onSurfaceVariant)
            }
        }
    }

    @ViewBuilder
    private func controlButton(icon: String, label: String, tint: Color) -> some View {
        Button {
            // Future implementation
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(tint)
                Text(label)
                    .font(.labelSM)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.onSurfaceVariant)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.surfaceContainerLow)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}
