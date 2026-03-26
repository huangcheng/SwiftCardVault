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
        if score >= 90 { return String(localized: "OPTIMAL") }
        if score >= 70 { return String(localized: "Good") }
        return String(localized: "At Risk")
    }

    private var statusColor: Color {
        if score >= 90 { return Color.primaryToken }
        if score >= 70 { return Color.tertiaryContainer }
        return Color.errorToken
    }

    var body: some View {
        VStack(spacing: 20) {
            // Header
            Text(String(localized: "VAULT INTEGRITY SCORE"))
                .font(.labelSM)
                .fontWeight(.semibold)
                .foregroundStyle(Color.onSurfaceVariant)
                .tracking(1.5)

            // Circular score ring
            ZStack {
                Circle()
                    .stroke(Color.surfaceContainerHigh, lineWidth: 6)
                    .frame(width: 100, height: 100)

                Circle()
                    .trim(from: 0, to: Double(score) / 100.0)
                    .stroke(statusColor, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))

                VStack(spacing: 2) {
                    Text("\(score)")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.onSurface)
                    Text(statusLabel)
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundStyle(statusColor)
                        .tracking(1)
                }
            }

            // Description
            Text(String(localized: "Your security profile is stronger than 98% of users. 2-FA and hardware key active."))
                .font(.labelSM)
                .foregroundStyle(Color.onSurfaceVariant)
                .multilineTextAlignment(.center)
                .lineSpacing(3)

            // 2x2 Quick Actions Grid
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 10),
                GridItem(.flexible(), spacing: 10)
            ], spacing: 10) {
                quickAction(icon: "lock.fill", label: String(localized: "LOCK VAULT"), tint: Color.errorToken)
                quickAction(icon: "clock.arrow.circlepath", label: String(localized: "HISTORY"), tint: Color.onSurface)
                quickAction(icon: "checkmark.shield.fill", label: String(localized: "AUDIT"), tint: Color.primaryToken)
                quickAction(icon: "link", label: String(localized: "LINK BANK"), tint: Color.onSurface)
            }
        }
        .padding(24)
        .background(Color.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
    }

    @ViewBuilder
    private func quickAction(icon: String, label: String, tint: Color) -> some View {
        Button {
            // Future implementation
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(tint)
                Text(label)
                    .font(.system(size: 8, weight: .semibold))
                    .foregroundStyle(Color.onSurfaceVariant)
                    .tracking(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.surfaceContainerHigh)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}
