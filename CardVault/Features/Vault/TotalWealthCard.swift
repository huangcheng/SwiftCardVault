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

    // MARK: - iOS compact (centered)
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

    // MARK: - macOS desktop: heading left, value pill right
    @ViewBuilder
    private var desktopLayout: some View {
        HStack(alignment: .top) {
            // Left: heading + subtitle
            VStack(alignment: .leading, spacing: 6) {
                Text(String(localized: "Digital Assets"))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.onSurface)

                Text(String(localized: "Monitoring \(max(1, Int(truncating: totalBalance as NSDecimalNumber) / 15000)) active cards across secure vaults"))
                    .font(.bodyMD)
                    .foregroundStyle(Color.onSurfaceVariant)
            }

            Spacer()

            // Right: total value pill
            HStack(spacing: 10) {
                VStack(alignment: .trailing, spacing: 2) {
                    Text(String(localized: "TOTAL WEALTH"))
                        .font(.system(size: 8, weight: .semibold))
                        .foregroundStyle(Color.onSurfaceVariant)
                        .tracking(1)

                    Text(totalBalance, format: .currency(code: "USD"))
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.onSurface)
                }

                HStack(spacing: 2) {
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 9, weight: .bold))
                    Text("\(growthPercentage, specifier: "%.0f")%")
                        .font(.labelSM)
                        .fontWeight(.bold)
                }
                .foregroundStyle(Color.primaryToken)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(Color.surfaceContainerLow)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
