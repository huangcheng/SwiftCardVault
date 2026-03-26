//
//  TotalWealthCard.swift
//  CardVault
//

import SwiftUI

struct TotalWealthCard: View {
    let totalBalance: Decimal
    let growthPercentage: Double
    let isCompact: Bool

    init(totalBalance: Decimal, growthPercentage: Double = 4.2, isCompact: Bool = true) {
        self.totalBalance = totalBalance
        self.growthPercentage = growthPercentage
        self.isCompact = isCompact
    }

    var body: some View {
        if isCompact {
            compactLayout
        } else {
            desktopLayout
        }
    }

    // MARK: - iOS compact (centered, in a card)
    @ViewBuilder
    private var compactLayout: some View {
        VStack(spacing: 4) {
            Text(String(localized: "Total Wealth"))
                .font(.bodyMD)
                .fontWeight(.medium)
                .foregroundStyle(Color.onSurfaceVariant)

            Text(totalBalance, format: .currency(code: "USD"))
                .font(.displayLG)
                .foregroundStyle(Color.onSurface)
                .minimumScaleFactor(0.5)
                .lineLimit(1)

            Text("+\(growthPercentage, specifier: "%.1f")% \(String(localized: "this month"))")
                .font(.labelSM)
                .foregroundStyle(Color.onSurfaceVariant)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
    }

    // MARK: - macOS desktop (left-aligned, no card background)
    @ViewBuilder
    private var desktopLayout: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(String(localized: "TOTAL SECURED VALUE"))
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color.onSurfaceVariant)
                .tracking(2)

            HStack(alignment: .firstTextBaseline, spacing: 16) {
                Text(totalBalance, format: .currency(code: "USD"))
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.onSurface)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                HStack(spacing: 4) {
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 11, weight: .semibold))
                    Text("\(growthPercentage, specifier: "%.1f")%")
                        .font(.labelSM)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(Color.primaryToken)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
