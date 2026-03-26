//
//  AddCardTile.swift
//  CardVault
//

import SwiftUI

struct AddCardTile: View {
    var body: some View {
        Button {
            // Navigate to add card — future implementation
        } label: {
            VStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color.primaryToken)
                        .frame(width: 40, height: 40)

                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                }

                Text(String(localized: "Add New Card"))
                    .font(.bodyMD)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.onSurfaceVariant)
            }
            .frame(maxWidth: .infinity, minHeight: 200)
            .background(Color.surfaceContainerLow.opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius)
                    .strokeBorder(
                        Color.outlineVariant.opacity(0.4),
                        style: StrokeStyle(lineWidth: 1.5, dash: [8, 6])
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddCardTile()
        .frame(width: 280, height: 200)
        .padding()
        .background(Color.surface)
}
