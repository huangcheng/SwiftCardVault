//
//  VaultView.swift
//  CardVault
//

import SwiftUI
import SwiftData

struct VaultView: View {
    @Query(sort: \CreditCard.displayOrder) private var cards: [CreditCard]
    @Query(sort: \SecurityEvent.timestamp, order: .reverse) private var securityEvents: [SecurityEvent]
    @State private var selectedCardIndex: Int?

    private var totalBalance: Decimal {
        cards.compactMap(\.currentBalance).reduce(0, +)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                #if os(iOS)
                iOSLayout
                #else
                macOSLayout
                #endif
            }
            .padding(.bottom, 32)
        }
        .background(Color.surface)
        .scrollClipDisabled()
    }

    // MARK: - iOS Layout

    #if os(iOS)
    @ViewBuilder
    private var iOSLayout: some View {
        VaultHeaderView()

        TotalWealthCard(totalBalance: totalBalance, isCompact: true)
            .padding(.horizontal, 20)

        if cards.isEmpty {
            VaultEmptyStateView()
        } else {
            cardStack
                .padding(.horizontal, 20)
        }

        SecurityRadarView(events: Array(securityEvents.prefix(5)))
            .padding(.horizontal, 20)
    }

    @ViewBuilder
    private var cardStack: some View {
        VStack(spacing: DesignConstants.cardOverlap) {
            ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                CardStackItem(
                    card: card,
                    isSelected: selectedCardIndex == index
                ) {
                    withAnimation(DesignConstants.cardTouchSpring) {
                        selectedCardIndex = selectedCardIndex == index ? nil : index
                    }
                }
                .zIndex(Double(cards.count - index))
            }
        }
    }
    #endif

    // MARK: - macOS Layout (matches Stitch Desktop Light comp)

    #if os(macOS)
    @ViewBuilder
    private var macOSLayout: some View {
        if cards.isEmpty {
            VaultEmptyStateView()
        } else {
            // Row 1: "Digital Assets" heading (left) | Total value pill (right)
            TotalWealthCard(totalBalance: totalBalance, isCompact: false)
                .padding(.horizontal, 32)

            // Row 2: "Active Vault Cards" label + cards
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text(String(localized: "Active Vault Cards"))
                        .font(.titleMD)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.onSurface)
                    Spacer()
                    Button {
                        // View all — future implementation
                    } label: {
                        Text(String(localized: "View All"))
                            .font(.labelSM)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.primaryToken)
                    }
                    .buttonStyle(.plain)
                }

                HStack(spacing: 16) {
                    ForEach(cards.prefix(2)) { card in
                        CardStackItem(card: card, isSelected: false)
                    }
                    AddCardTile()
                }
            }
            .padding(.horizontal, 32)

            // Row 3: Security Events (left ~60%) | Quick Controls (right ~40%)
            HStack(alignment: .top, spacing: 20) {
                SecurityRadarView(events: Array(securityEvents.prefix(5)))
                    .frame(maxWidth: .infinity)

                VStack(spacing: 16) {
                    QuickControlsView()
                    VaultIntegrityView(cards: cards)
                }
                .frame(width: 260)
            }
            .padding(.horizontal, 32)
        }
    }
    #endif
}

#Preview {
    VaultView()
        .modelContainer(for: [CreditCard.self, SecurityEvent.self], inMemory: true)
}
