//
//  VaultStreamView.swift
//  CardVault
//

import SwiftUI

struct VaultStreamView: View {
    let events: [SecurityEvent]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with subtitle and export
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(String(localized: "Vault Stream"))
                        .font(.headlineSM)
                        .foregroundStyle(Color.onSurface)
                    Text(String(localized: "Real-time security monitoring and card usage"))
                        .font(.labelSM)
                        .foregroundStyle(Color.onSurfaceVariant)
                }

                Spacer()

                Button {
                    // Export action
                } label: {
                    HStack(spacing: 4) {
                        Text(String(localized: "Export Logs"))
                            .font(.labelSM)
                            .fontWeight(.medium)
                        Image(systemName: "arrow.up.right")
                            .font(.system(size: 9))
                    }
                    .foregroundStyle(Color.primaryToken)
                }
                .buttonStyle(.plain)
            }

            // Transaction rows
            if events.isEmpty {
                Text(String(localized: "No recent activity"))
                    .font(.bodyMD)
                    .foregroundStyle(Color.onSurfaceVariant)
                    .padding(.vertical, 16)
            } else {
                VStack(spacing: 0) {
                    ForEach(Array(events.prefix(5).enumerated()), id: \.element.id) { index, event in
                        streamRow(event: event, index: index)
                    }
                }
            }
        }
        .padding(24)
        .background(Color.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
    }

    @ViewBuilder
    private func streamRow(event: SecurityEvent, index: Int) -> some View {
        HStack(spacing: 14) {
            // Icon
            Image(systemName: iconForEvent(event.eventType))
                .font(.body)
                .foregroundStyle(Color.onSurface)
                .frame(width: 36, height: 36)
                .background(Color.surfaceContainerHigh)
                .clipShape(RoundedRectangle(cornerRadius: 10))

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
                    } else {
                        Text(streamSubtitle(for: event, index: index))
                    }
                    Text("•")
                    Text(streamTimestamp(index: index))
                }
                .font(.labelSM)
                .foregroundStyle(Color.onSurfaceVariant)
            }

            Spacer()

            // Amount or status
            VStack(alignment: .trailing, spacing: 2) {
                if let amount = streamAmount(index: index) {
                    Text(amount)
                        .font(.bodyMD)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.onSurface)
                }

                HStack(spacing: 4) {
                    if event.eventType == .loginDetected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.primaryToken)
                        Text(String(localized: "AUTHORIZED"))
                            .font(.system(size: 9, weight: .semibold))
                            .foregroundStyle(Color.primaryToken)
                            .tracking(0.5)
                    } else {
                        Text(String(localized: "VERIFIED"))
                            .font(.system(size: 9, weight: .semibold))
                            .foregroundStyle(Color.onSurfaceVariant)
                            .tracking(0.5)
                    }
                }
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(index % 2 == 0 ? Color.surfaceContainer.opacity(0.5) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func iconForEvent(_ type: SecurityEventType) -> String {
        switch type {
        case .loginDetected: "person.badge.shield.checkmark"
        case .encryptionUpdated: "lock.rotation"
        case .biometricChanged: "faceid"
        case .cardAdded: "bag.fill"
        case .cardDeleted: "minus.circle"
        case .cardLocked: "lock"
        case .cardUnlocked: "lock.open"
        case .exportPerformed: "airplane"
        case .importPerformed: "square.and.arrow.down"
        }
    }

    // Sample contextual data matching Stitch comp
    private func streamSubtitle(for event: SecurityEvent, index: Int) -> String {
        switch index {
        case 0: "Premium Vault Card"
        case 1: "MacOS 14.2 • New York, NY"
        case 2: "Business Entity Card"
        default: "Vault Activity"
        }
    }

    private func streamTimestamp(index: Int) -> String {
        switch index {
        case 0: "Today, 11:42 AM"
        case 1: ""
        case 2: "Yesterday"
        default: "Recently"
        }
    }

    private func streamAmount(index: Int) -> String? {
        switch index {
        case 0: "-$1,299.00"
        case 2: "-$842.20"
        default: nil
        }
    }
}
