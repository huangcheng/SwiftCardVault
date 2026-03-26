//
//  LockScreenView.swift
//  CardVault
//

import SwiftUI

struct LockScreenView: View {
    @Environment(AppState.self) private var appState
    @State private var isAuthenticating = false
    @State private var authFailed = false

    var body: some View {
        ZStack {
            Color.surface
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(Color.primaryToken)
                    .symbolEffect(.pulse, options: .repeating, isActive: !isAuthenticating)

                VStack(spacing: 8) {
                    Text("The Vault")
                        .font(.headlineSM)
                        .foregroundStyle(Color.onSurface)

                    Text("Your cards are secured")
                        .font(.bodyMD)
                        .foregroundStyle(Color.onSurfaceVariant)
                }

                Spacer()

                if authFailed {
                    Text("Authentication failed. Please try again.")
                        .font(.labelSM)
                        .foregroundStyle(Color.errorToken)
                        .padding(.bottom, 8)
                }

                Button {
                    authenticate()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: biometricIcon)
                        Text("Unlock")
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(isAuthenticating)

                Spacer()
                    .frame(height: 60)
            }
            .padding()
        }
        .onAppear {
            authenticate()
        }
    }

    private var biometricIcon: String {
        switch BiometricService.biometricType() {
        case .faceID: "faceid"
        case .touchID: "touchid"
        case .none: "lock.open"
        }
    }

    private func authenticate() {
        isAuthenticating = true
        authFailed = false

        Task {
            let success = await BiometricService.authenticate()
            await MainActor.run {
                isAuthenticating = false
                if success {
                    appState.unlock()
                } else {
                    authFailed = true
                }
            }
        }
    }
}

#Preview {
    LockScreenView()
        .environment(AppState(previewMode: false))
}
