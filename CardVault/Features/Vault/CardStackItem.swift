//
//  CardStackItem.swift
//  CardVault
//

import SwiftUI

struct CardStackItem: View {
    let card: CreditCard
    let isSelected: Bool
    var onTap: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: card.cardNetwork.sfSymbolName)
                    .font(.title3)
                    .foregroundStyle(Color.white.opacity(0.9))

                Text(card.cardNetwork.displayName)
                    .font(.labelSM)
                    .foregroundStyle(Color.white.opacity(0.7))
                    .textCase(.uppercase)

                Spacer()

                statusBadge
            }

            Spacer()

            Text("•••• •••• •••• \(card.lastFourDigits)")
                .font(.cardNumber)
                .foregroundStyle(Color.white.opacity(0.9))
                .tracking(2)

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(card.nickname.isEmpty ? card.cardholderName : card.nickname)
                        .font(.titleMD)
                        .foregroundStyle(Color.white)
                    Text(card.issuerName)
                        .font(.labelSM)
                        .foregroundStyle(Color.white.opacity(0.6))
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    if let balance = card.currentBalance {
                        Text(balance, format: .currency(code: "USD"))
                            .font(.titleMD)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                    }
                    Text(String(format: "%02d/%02d", card.expirationMonth, card.expirationYear % 100))
                        .font(.labelSM)
                        .foregroundStyle(Color.white.opacity(0.6))
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .frame(height: 220)
        .background(cardGradient)
        .cardShape()
        .offset(y: isSelected ? -DesignConstants.cardTranslateDistance : 0)
        .animation(DesignConstants.cardTouchSpring, value: isSelected)
        .onTapGesture { onTap() }
    }

    private var cardGradient: some ShapeStyle {
        LinearGradient(
            colors: [Color(hex: card.cardColor), Color(hex: card.cardColor).opacity(0.7)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    @ViewBuilder
    private var statusBadge: some View {
        let status = cardStatus
        Text(status.text)
            .font(.labelSM)
            .fontWeight(.medium)
            .foregroundStyle(status.foreground)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(status.background.opacity(0.3))
            .clipShape(Capsule())
    }

    private var cardStatus: (text: String, foreground: Color, background: Color) {
        if card.isPaidThisCycle {
            return (String(localized: "Paid"), .white, Color.primaryToken)
        }

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.year, .month], from: today)
        guard let year = components.year, let month = components.month else {
            return (String(localized: "Paid"), .white, Color.primaryToken)
        }

        var dueDateComponents = DateComponents()
        dueDateComponents.year = year
        dueDateComponents.month = month
        dueDateComponents.day = card.paymentDueDate

        if let dueDate = calendar.date(from: dueDateComponents) {
            let daysUntilDue = calendar.dateComponents([.day], from: today, to: dueDate).day ?? 0
            if daysUntilDue < 0 {
                return (String(localized: "Overdue"), .white, Color.errorToken)
            } else {
                return (String(localized: "Due in \(daysUntilDue) days"), .white, Color.tertiaryContainer)
            }
        }

        return (String(localized: "Paid"), .white, Color.primaryToken)
    }
}

// MARK: - Color from Hex

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0x3E, 0x90, 0xFF)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}
