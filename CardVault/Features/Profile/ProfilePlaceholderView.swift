//
//  ProfilePlaceholderView.swift
//  CardVault
//

import SwiftUI

struct ProfilePlaceholderView: View {
    var body: some View {
        ZStack {
            Color.surface
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.primaryToken)

                Text("Profile")
                    .font(.headlineSM)
                    .foregroundStyle(Color.onSurface)

                Text("Statistics & settings coming soon")
                    .font(.bodyMD)
                    .foregroundStyle(Color.onSurfaceVariant)
            }
        }
    }
}

#Preview {
    ProfilePlaceholderView()
}
