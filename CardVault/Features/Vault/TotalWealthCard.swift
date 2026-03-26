//
//  TotalWealthCard.swift
//  CardVault
//

import SwiftUI

struct TotalWealthCard: View {
    let totalBalance: Decimal
    let growthPercentage: Double
    let isCompact: Bool

    init(totalBalance: Decimal, growthPercentage: Double = 2.4, isCompact: Bool = true) {
        self.totalBalance = totalBalance
        self.growthPercentage = growthPercentage
        self.isCompact = isCompact
    }

    var body: some View {
        VStack(alignment: isCompact ? .center : .leading, spacing: 8) {
            Text(isCompact ? String(localized: "Total Wealth") : String(localized: "Total Secured Value"))
                .font(.labelSM)
                .foregroundStyle(Color.onSurfaceVariant)
                .textCase(.uppercase)
                .tracking(1)

            Text(totalBalance, format: .currency(code: "USD"))
                .font(.displayLG)
                .foregroundStyle(Color.onSurface)
                .minimumScaleFactor(0.5)
                .lineLimit(1)

            HStack(spacing: 6) {
                Image(systemName: growthPercentage >= 0 ? "trending_up" : "trending_down")
                    .font(.labelSM)

                Text("+\(growthPercentage, specifier: "%.1f")% \(String(localized: "this month"))")
                    .font(.labelSM)
                    .fontWeight(.medium)
            }
            .foregroundStyle(Color.primaryToken)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.primaryContainer.opacity(0.2))
            .clipShape(Capsule())

            Text(String(localized: "Updated 2m ago"))
                .font(.labelSM)
                .foregroundStyle(Color.onSurfaceVariant.opacity(0.6))
        }
        .padding(isCompact ? 24 : 32)
        .frame(maxWidth: .infinity)
        .background(Color.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
    }
}
