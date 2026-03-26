//
//  AddCardDesktopView.swift
//  CardVault
//

import SwiftUI
import SwiftData

struct AddCardDesktopView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var formState = AddCardFormState()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header row
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(String(localized: "Register New Card"))
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color.onSurface)

                        Text(String(localized: "Configure your payment instrument and billing parameters."))
                            .font(.bodyMD)
                            .foregroundStyle(Color.onSurfaceVariant)
                    }

                    Spacer()

                    Button {
                        isPresented = false
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 12))
                            Text(String(localized: "Back to Cards"))
                                .font(.bodyMD)
                                .fontWeight(.medium)
                        }
                        .foregroundStyle(Color.primaryToken)
                    }
                    .buttonStyle(.plain)
                }

                // Two-column layout
                HStack(alignment: .top, spacing: 32) {
                    // Left column: network + form
                    VStack(alignment: .leading, spacing: 24) {
                        // SELECT NETWORK
                        VStack(alignment: .leading, spacing: 12) {
                            Text(String(localized: "SELECT NETWORK"))
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color.onSurfaceVariant)
                                .tracking(1.5)

                            @Bindable var state = formState
                            NetworkSelectorView(selectedNetwork: $state.selectedNetwork, style: .icons)
                        }
                        .padding(20)
                        .background(Color.surfaceContainerLow)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                        // CARD INFORMATION
                        VStack(alignment: .leading, spacing: 16) {
                            Text(String(localized: "CARD INFORMATION"))
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color.onSurfaceVariant)
                                .tracking(1.5)

                            // Cardholder Name
                            VStack(alignment: .leading, spacing: 4) {
                                Text(String(localized: "Cardholder Name"))
                                    .font(.labelSM)
                                    .foregroundStyle(Color.onSurfaceVariant)

                                TextField(String(localized: "e.g. JAMES MORRISON"), text: $formState.cardholderName)
                                    .font(.bodyMD)
                                    .foregroundStyle(Color.onSurface)
                                    .padding(12)
                                    .background(Color.surfaceContainerLow)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                            // Card Number
                            VStack(alignment: .leading, spacing: 4) {
                                Text(String(localized: "Card Number"))
                                    .font(.labelSM)
                                    .foregroundStyle(Color.onSurfaceVariant)

                                CardNumberField(formState: formState)
                            }

                            // Expiry + CVV
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(String(localized: "Expiry Date"))
                                        .font(.labelSM)
                                        .foregroundStyle(Color.onSurfaceVariant)

                                    TextField(String(localized: "MM/YY"), text: Binding(
                                        get: { formState.formattedExpiry },
                                        set: { formState.expiryText = $0.filter(\.isNumber) }
                                    ))
                                    .font(.bodyMD)
                                    .padding(12)
                                    .background(Color.surfaceContainerLow)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(String(localized: "CVV"))
                                        .font(.labelSM)
                                        .foregroundStyle(Color.onSurfaceVariant)

                                    SecureField("•••", text: $formState.cvv)
                                        .font(.bodyMD)
                                        .padding(12)
                                        .background(Color.surfaceContainerLow)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .padding(20)
                        .background(Color.surfaceContainerLow)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .frame(maxWidth: .infinity)

                    // Right column: preview + billing + CTA
                    VStack(alignment: .leading, spacing: 24) {
                        // Live card preview
                        CardStackItem(
                            card: previewCard,
                            isSelected: false
                        )

                        // BILLING CONFIGURATION
                        VStack(alignment: .leading, spacing: 16) {
                            Text(String(localized: "BILLING CONFIGURATION"))
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color.onSurfaceVariant)
                                .tracking(1.5)

                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(String(localized: "Billing Date"))
                                        .font(.labelSM)
                                        .foregroundStyle(Color.onSurfaceVariant)

                                    @Bindable var state = formState
                                    Picker("", selection: $state.billingDate) {
                                        Text(String(localized: "1st of Month")).tag(1)
                                        Text(String(localized: "15th of Month")).tag(15)
                                        Text(String(localized: "28th of Month")).tag(28)
                                    }
                                    .labelsHidden()
                                    .padding(8)
                                    .background(Color.surfaceContainerLow)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(String(localized: "Due Date"))
                                        .font(.labelSM)
                                        .foregroundStyle(Color.onSurfaceVariant)

                                    @Bindable var state = formState
                                    Picker("", selection: $state.paymentDueDate) {
                                        Text(String(localized: "10 Days Later")).tag(10)
                                        Text(String(localized: "15 Days Later")).tag(15)
                                        Text(String(localized: "21 Days Later")).tag(21)
                                    }
                                    .labelsHidden()
                                    .padding(8)
                                    .background(Color.surfaceContainerLow)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(String(localized: "Credit Limit"))
                                    .font(.labelSM)
                                    .foregroundStyle(Color.onSurfaceVariant)

                                HStack {
                                    Text("$")
                                        .font(.bodyMD)
                                        .foregroundStyle(Color.onSurfaceVariant)
                                    TextField(String(localized: "5,000"), text: $formState.creditLimitText)
                                        .font(.bodyMD)
                                        .foregroundStyle(Color.onSurface)
                                }
                                .padding(12)
                                .background(Color.surfaceContainerLow)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }

                        // CTA
                        Button {
                            saveCard()
                        } label: {
                            HStack {
                                Spacer()
                                Text(String(localized: "Finalize Registration"))
                                Image(systemName: "chevron.right")
                                Spacer()
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .disabled(!formState.isValid)
                        .opacity(formState.isValid ? 1.0 : 0.5)

                        // Disclaimer
                        Text(String(localized: "Your card data is encrypted and stored in an ISO-27001 vault."))
                            .font(.labelSM)
                            .foregroundStyle(Color.onSurfaceVariant.opacity(0.6))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(32)
        }
        .background(Color.surface)
    }

    private var previewCard: CreditCard {
        CreditCard(
            nickname: formState.cardholderName.isEmpty ? "Card Preview" : formState.cardholderName,
            cardholderName: formState.cardholderName.isEmpty ? "JAMES MORRISON" : formState.cardholderName,
            lastFourDigits: formState.lastFourDigits.isEmpty ? "4242" : formState.lastFourDigits,
            cardNetwork: formState.selectedNetwork,
            issuerName: formState.selectedNetwork.displayName,
            expirationMonth: formState.expiryMonth,
            expirationYear: formState.expiryYear,
            cardColor: cardColorForNetwork(formState.selectedNetwork)
        )
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
            billingDate: formState.billingDate,
            paymentDueDate: formState.billingDate + formState.paymentDueDate,
            creditLimit: formState.creditLimit,
            currentBalance: 0,
            cardColor: cardColorForNetwork(formState.selectedNetwork)
        )

        modelContext.insert(card)
        KeychainService.saveCardNumber(formState.cardNumberRaw, for: card.id)
        KeychainService.saveCVV(formState.cvv, for: card.id)

        let event = SecurityEvent(
            eventType: .cardAdded,
            eventDescription: "New Card Added to Vault",
            riskLevel: .low
        )
        modelContext.insert(event)

        isPresented = false
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
