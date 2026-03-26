//
//  SecurityRadarView.swift
//  CardVault
//

import SwiftUI

struct SecurityRadarView: View {
    let events: [SecurityEvent]

    private var alertCount: Int {
        events.filter { $0.riskLevel == .medium || $0.riskLevel == .high }.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Header — outside the card container
            HStack {
                Text(String(localized: "Recent Security Events"))
                    .font(.headlineSM)
                    .foregroundStyle(Color.onSurface)

                Spacer()

                if alertCount > 0 {
                    Text("\(alertCount) Alerts")
                        .font(.labelSM)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.errorToken)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.errorToken.opacity(0.12))
                        .clipShape(Capsule())
                }
            }

            // Event rows — inside a rounded card container
            if events.isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "checkmark.shield")
                            .font(.title)
                            .foregroundStyle(Color.primaryToken)
                        Text(String(localized: "No recent events"))
                            .font(.bodyMD)
                            .foregroundStyle(Color.onSurfaceVariant)
                    }
                    .padding(.vertical, 24)
                    Spacer()
                }
                .background(Color.surfaceContainerLow)
                .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
            } else {
                VStack(spacing: 0) {
                    ForEach(events) { event in
                        SecurityEventRow(event: event)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.surfaceContainerLow)
                .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
            }
        }
    }
}

struct SecurityEventRow: View {
    let event: SecurityEvent

    var body: some View {
        HStack(spacing: 12) {
            // Icon circle
            Image(systemName: iconForEventType(event.eventType))
                .font(.body)
                .foregroundStyle(colorForRiskLevel(event.riskLevel))
                .frame(width: 36, height: 36)
                .background(colorForRiskLevel(event.riskLevel).opacity(0.1))
                .clipShape(Circle())

            // Content
            VStack(alignment: .leading, spacing: 2) {
                Text(event.eventDescription)
                    .font(.bodyMD)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.onSurface)
                    .lineLimit(1)

                HStack(spacing: 4) {
                    if let location = event.location {
                        Text(location)
                        Text("•")
                    }
                    Text(event.timestamp, style: .relative)
                }
                .font(.labelSM)
                .foregroundStyle(Color.onSurfaceVariant)
            }

            Spacer()

            // Status label
            Text(statusLabel(for: event.riskLevel))
                .font(.system(size: 9, weight: .bold))
                .tracking(0.5)
                .foregroundStyle(colorForRiskLevel(event.riskLevel))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
    }

    nonisolated private func iconForEventType(_ type: SecurityEventType) -> String {
        switch type {
        case .loginDetected: "person.badge.shield.checkmark"
        case .encryptionUpdated: "lock.rotation"
        case .biometricChanged: "faceid"
        case .cardAdded: "plus.circle"
        case .cardDeleted: "minus.circle"
        case .cardLocked: "lock"
        case .cardUnlocked: "lock.open"
        case .exportPerformed: "square.and.arrow.up"
        case .importPerformed: "square.and.arrow.down"
        }
    }

    private func colorForRiskLevel(_ level: RiskLevel) -> Color {
        switch level {
        case .low: Color.primaryToken
        case .medium: Color.tertiaryContainer
        case .high: Color.errorToken
        }
    }

    private func statusLabel(for level: RiskLevel) -> String {
        switch level {
        case .low: String(localized: "SYSTEM")
        case .medium: String(localized: "ALERT")
        case .high: String(localized: "HIGH RISK")
        }
    }
}
