//
//  VaultStreamView.swift
//  CardVault
//

import SwiftUI

struct VaultStreamView: View {
    let events: [SecurityEvent]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(String(localized: "Vault Stream"))
                    .font(.headlineSM)
                    .foregroundStyle(Color.onSurface)

                Spacer()

                Button {
                    // Export action — future implementation
                } label: {
                    HStack(spacing: 4) {
                        Text(String(localized: "Export"))
                            .font(.labelSM)
                        Image(systemName: "square.and.arrow.down")
                            .font(.labelSM)
                    }
                    .foregroundStyle(Color.primaryToken)
                }
                .buttonStyle(.plain)
            }

            if events.isEmpty {
                Text(String(localized: "No recent activity"))
                    .font(.bodyMD)
                    .foregroundStyle(Color.onSurfaceVariant)
                    .padding(.vertical, 16)
            } else {
                VStack(spacing: 0) {
                    ForEach(Array(events.prefix(10))) { event in
                        HStack(spacing: 12) {
                            Circle()
                                .fill(Color.primaryToken.opacity(0.2))
                                .frame(width: 8, height: 8)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(event.eventDescription)
                                    .font(.bodyMD)
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

                            Text(String(localized: "Verified"))
                                .font(.labelSM)
                                .foregroundStyle(Color.primaryToken)
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .padding(24)
        .background(Color.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
    }
}
