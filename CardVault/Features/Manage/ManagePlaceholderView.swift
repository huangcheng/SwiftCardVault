//
//  ManagePlaceholderView.swift
//  CardVault
//

import SwiftUI

struct ManagePlaceholderView: View {
    var body: some View {
        ZStack {
            Color.surface
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "creditcard")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.primaryToken)

                Text("Manage")
                    .font(.headlineSM)
                    .foregroundStyle(Color.onSurface)

                Text("Card management coming soon")
                    .font(.bodyMD)
                    .foregroundStyle(Color.onSurfaceVariant)
            }
        }
    }
}

#Preview {
    ManagePlaceholderView()
}
