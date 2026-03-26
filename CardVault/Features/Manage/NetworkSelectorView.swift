//
//  NetworkSelectorView.swift
//  CardVault
//

import SwiftUI

struct NetworkSelectorView: View {
    @Binding var selectedNetwork: CardNetwork
    var style: NetworkSelectorStyle = .pills

    enum NetworkSelectorStyle {
        case pills   // Mobile: horizontal capsule pills
        case icons   // Desktop: icon + label buttons
    }

    var body: some View {
        switch style {
        case .pills:
            pillsLayout
        case .icons:
            iconsLayout
        }
    }

    // MARK: - Mobile Pills (from Stitch mobile comp)
    @ViewBuilder
    private var pillsLayout: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(CardNetwork.allCases) { network in
                    Button {
                        selectedNetwork = network
                    } label: {
                        Text(network.shortLabel)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(selectedNetwork == network ? Color.white : Color.onSurfaceVariant)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(selectedNetwork == network ? Color.primaryToken : Color.surfaceContainerHigh)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(
                                        selectedNetwork == network ? Color.primaryToken : Color.outlineVariant.opacity(0.3),
                                        lineWidth: 1
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    // MARK: - Desktop Icons (from Stitch desktop comp)
    @ViewBuilder
    private var iconsLayout: some View {
        HStack(spacing: 12) {
            ForEach([CardNetwork.visa, .mastercard, .amex, .discover], id: \.self) { network in
                Button {
                    selectedNetwork = network
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: network.sfSymbolName)
                            .font(.title2)
                            .foregroundStyle(selectedNetwork == network ? .white : Color.onSurfaceVariant)
                        Text(network.shortLabel)
                            .font(.system(size: 9, weight: .semibold))
                            .foregroundStyle(selectedNetwork == network ? .white : Color.onSurfaceVariant)
                            .tracking(0.5)
                    }
                    .frame(width: 64, height: 64)
                    .background(selectedNetwork == network ? Color.primaryToken : Color.surfaceContainerLow)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// Short labels matching Stitch comps
extension CardNetwork {
    var shortLabel: String {
        switch self {
        case .visa: "VISA"
        case .mastercard: "MASTER"
        case .amex: "AMEX"
        case .unionpay: "UNIO"
        case .jcb: "JCB"
        case .discover: "DISCOVER"
        }
    }
}
