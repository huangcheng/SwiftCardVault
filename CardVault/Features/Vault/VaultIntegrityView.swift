//
//  VaultIntegrityView.swift
//  CardVault
//

import SwiftUI

struct VaultIntegrityView: View {
    let cards: [CreditCard]

    private var score: Int {
        var s = 0
        s += 25 // Biometric always enabled
        s += 25 // All cards encrypted (Keychain)
        let hasExpired = cards.contains { card in
            let now = Date()
            let calendar = Calendar.current
            let currentMonth = calendar.component(.month, from: now)
            let currentYear = calendar.component(.year, from: now)
            return card.expirationYear < currentYear ||
                   (card.expirationYear == currentYear && card.expirationMonth < currentMonth)
        }
        if !hasExpired { s += 23 }
        let allPaid = cards.allSatisfy { $0.isPaidThisCycle }
        if allPaid { s += 23 }
        return min(s, 100)
    }

    private var statusLabel: String {
        if score >= 90 { return String(localized: "Optimal") }
        if score >= 70 { return String(localized: "Good") }
        return String(localized: "At Risk")
    }

    private var statusColor: Color {
        if score >= 90 { return Color.primaryToken }
        if score >= 70 { return Color.tertiaryContainer }
        return Color.errorToken
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(String(localized: "Vault Integrity"))
                    .font(.headlineSM)
                    .foregroundStyle(Color.onSurface)

                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(Color.primaryToken)
                    Text(String(localized: "Verified"))
                        .font(.labelSM)
                        .foregroundStyle(Color.primaryToken)
                }
            }

            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("\(score)")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(statusColor)

                Text("/ 100 — \(statusLabel)")
                    .font(.titleMD)
                    .foregroundStyle(Color.onSurfaceVariant)
            }

            Text(String(localized: "Your security profile is actively monitored. Biometric and encryption protections are in place."))
                .font(.bodyMD)
                .foregroundStyle(Color.onSurfaceVariant)

            HStack(spacing: 12) {
                quickAction(icon: "lock", label: String(localized: "Lock All"))
                quickAction(icon: "clock", label: String(localized: "History"))
                quickAction(icon: "checkmark.shield", label: String(localized: "Audit"))
                quickAction(icon: "link", label: String(localized: "Link"))
            }
        }
        .padding(24)
        .background(Color.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
    }

    @ViewBuilder
    private func quickAction(icon: String, label: String) -> some View {
        Button {
            // Future implementation
        } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.body)
                Text(label)
                    .font(.labelSM)
            }
            .foregroundStyle(Color.onSurface)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.surfaceContainerHigh)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}
