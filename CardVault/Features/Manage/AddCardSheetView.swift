//
//  AddCardSheetView.swift
//  CardVault
//

import SwiftUI
import SwiftData

struct AddCardSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var formState = AddCardFormState()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Title section
                    VStack(alignment: .leading, spacing: 6) {
                        Text(String(localized: "New Asset"))
                            .font(.headlineSM)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.onSurface)

                        Text(String(localized: "Enter your physical card credentials to encrypt them into the vault."))
                            .font(.bodyMD)
                            .foregroundStyle(Color.onSurfaceVariant)
                    }

                    // CARD NUMBER
                    VStack(alignment: .leading, spacing: 8) {
                        Text(String(localized: "CARD NUMBER"))
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(Color.onSurfaceVariant)
                            .tracking(1.5)

                        CardNumberField(formState: formState)
                    }

                    // CARD NETWORK
                    VStack(alignment: .leading, spacing: 8) {
                        Text(String(localized: "CARD NETWORK"))
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(Color.onSurfaceVariant)
                            .tracking(1.5)

                        @Bindable var state = formState
                        NetworkSelectorView(selectedNetwork: $state.selectedNetwork, style: .pills)
                    }

                    // CARDHOLDER NAME
                    VStack(alignment: .leading, spacing: 8) {
                        Text(String(localized: "CARDHOLDER NAME"))
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(Color.onSurfaceVariant)
                            .tracking(1.5)

                        TextField(String(localized: "NAME ON CARD"), text: $formState.cardholderName)
                            .font(.bodyMD)
                            .foregroundStyle(Color.onSurface)
                            #if os(iOS)
                            .textInputAutocapitalization(.characters)
                            #endif
                            .padding(14)
                            .background(Color.surfaceContainerLow)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    // EXPIRY DATE + SECURITY CODE side by side
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(String(localized: "EXPIRY DATE"))
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color.onSurfaceVariant)
                                .tracking(1.5)

                            TextField(String(localized: "MM/YY"), text: Binding(
                                get: { formState.formattedExpiry },
                                set: { formState.expiryText = $0.filter(\.isNumber) }
                            ))
                            .font(.bodyMD)
                            .foregroundStyle(Color.onSurface)
                            #if os(iOS)
                            .keyboardType(.numberPad)
                            #endif
                            .padding(14)
                            .background(Color.surfaceContainerLow)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text(String(localized: "SECURITY CODE"))
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color.onSurfaceVariant)
                                .tracking(1.5)

                            SecureField("•••", text: $formState.cvv)
                                .font(.bodyMD)
                                .foregroundStyle(Color.onSurface)
                                #if os(iOS)
                                .keyboardType(.numberPad)
                                #endif
                                .padding(14)
                                .background(Color.surfaceContainerLow)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }

                    // CTA Button
                    Button {
                        saveCard()
                    } label: {
                        HStack {
                            Spacer()
                            Text(String(localized: "Continue to Terms"))
                            Image(systemName: "arrow.right")
                            Spacer()
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(!formState.isValid)
                    .opacity(formState.isValid ? 1.0 : 0.5)

                    // Shield icon
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.shield.fill")
                            .font(.title2)
                            .foregroundStyle(Color.primaryToken.opacity(0.4))
                        Spacer()
                    }
                    .padding(.top, 8)
                }
                .padding(24)
            }
            .background(Color.surface)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }

    private func saveCard() {
        let card = CreditCard(
            nickname: "",
            cardholderName: formState.cardholderName,
            lastFourDigits: formState.lastFourDigits,
            cardNetwork: formState.selectedNetwork,
            issuerName: formState.selectedNetwork.displayName,
            expirationMonth: formState.expiryMonth,
            expirationYear: formState.expiryYear,
            billingDate: 1,
            paymentDueDate: 15,
            creditLimit: nil,
            currentBalance: 0,
            cardColor: cardColorForNetwork(formState.selectedNetwork)
        )

        modelContext.insert(card)

        // Save secrets to Keychain
        KeychainService.saveCardNumber(formState.cardNumberRaw, for: card.id)
        KeychainService.saveCVV(formState.cvv, for: card.id)

        // Create security event
        let event = SecurityEvent(
            eventType: .cardAdded,
            eventDescription: "New Card Added to Vault",
            riskLevel: .low
        )
        modelContext.insert(event)

        dismiss()
    }

    nonisolated private func cardColorForNetwork(_ network: CardNetwork) -> String {
        switch network {
        case .visa: "#003d7a"
        case .mastercard: "#1a1a2e"
        case .amex: "#1a237e"
        case .unionpay: "#c62828"
        case .jcb: "#2e7d32"
        case .discover: "#e65100"
        }
    }
}
