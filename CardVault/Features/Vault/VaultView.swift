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

    // MARK: - macOS Layout

    #if os(macOS)
    @ViewBuilder
    private var macOSLayout: some View {
        TotalWealthCard(totalBalance: totalBalance, isCompact: false)
            .padding(.horizontal, 32)

        if cards.isEmpty {
            VaultEmptyStateView()
        } else {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                ForEach(cards) { card in
                    CardStackItem(card: card, isSelected: false)
                }
            }
            .padding(.horizontal, 32)
        }

        HStack(spacing: 16) {
            VaultIntegrityView(cards: cards)
            VaultStreamView(events: Array(securityEvents.prefix(10)))
        }
        .padding(.horizontal, 32)

        SecurityRadarView(events: Array(securityEvents.prefix(5)))
            .padding(.horizontal, 32)
    }
    #endif
}

#Preview {
    VaultView()
        .modelContainer(for: [CreditCard.self, SecurityEvent.self], inMemory: true)
}
