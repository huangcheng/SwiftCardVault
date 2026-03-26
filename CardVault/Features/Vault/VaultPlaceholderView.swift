//
//  VaultPlaceholderView.swift
//  CardVault
//

import SwiftUI

struct VaultPlaceholderView: View {
    var body: some View {
        ZStack {
            Color.surface
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "wallet.bifold")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.primaryToken)

                Text("Vault")
                    .font(.headlineSM)
                    .foregroundStyle(Color.onSurface)

                Text("Dashboard coming soon")
                    .font(.bodyMD)
                    .foregroundStyle(Color.onSurfaceVariant)
            }
        }
    }
}

#Preview {
    VaultPlaceholderView()
}
