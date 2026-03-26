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
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(String(localized: "Vault Integrity"))
                    .font(.titleMD)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.onSurface)

                Spacer()

                Text("\(score)%")
                    .font(.titleMD)
                    .fontWeight(.bold)
                    .foregroundStyle(statusColor)
            }

            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.surfaceContainerHigh)
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(statusColor)
                        .frame(width: geometry.size.width * Double(score) / 100.0, height: 8)
                }
            }
            .frame(height: 8)

            Text(String(localized: "Your vault status is excellent. Add MFA to reach 100% protection score."))
                .font(.labelSM)
                .foregroundStyle(Color.onSurfaceVariant)
                .lineSpacing(2)
        }
        .padding(20)
        .background(Color.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
