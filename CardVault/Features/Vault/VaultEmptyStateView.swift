//
//  VaultEmptyStateView.swift
//  CardVault
//

import SwiftUI

struct VaultEmptyStateView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "wallet.bifold")
                .font(.system(size: 64))
                .foregroundStyle(Color.primaryToken)
                .symbolEffect(.pulse, options: .repeating)

            VStack(spacing: 8) {
                Text(String(localized: "Your vault is empty"))
                    .font(.headlineSM)
                    .foregroundStyle(Color.onSurface)

                Text(String(localized: "Add your first card to get started"))
                    .font(.bodyMD)
                    .foregroundStyle(Color.onSurfaceVariant)
            }

            Button {
                // Navigate to add card — future implementation
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                    Text(String(localized: "Add Card"))
                }
            }
            .buttonStyle(PrimaryButtonStyle())

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(40)
    }
}
