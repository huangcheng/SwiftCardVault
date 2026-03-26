//
//  VaultHeaderView.swift
//  CardVault
//

import SwiftUI

struct VaultHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "lock.shield.fill")
                .font(.title2)
                .foregroundStyle(Color.primaryToken)

            Text(String(localized: "The Vault"))
                .font(.headlineSM)
                .foregroundStyle(Color.onSurface)

            Spacer()

            Button {
                // Settings action — future implementation
            } label: {
                Image(systemName: "gearshape")
                    .font(.title3)
                    .foregroundStyle(Color.onSurfaceVariant)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}
