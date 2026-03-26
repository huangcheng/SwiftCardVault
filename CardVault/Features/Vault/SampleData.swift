//
//  SampleData.swift
//  CardVault
//

import Foundation
import SwiftData

enum SampleData {

    static func seedIfNeeded(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<CreditCard>()
        let count = (try? modelContext.fetchCount(descriptor)) ?? 0
        guard count == 0 else { return }

        for card in cards {
            modelContext.insert(card)
        }
        for event in securityEvents {
            modelContext.insert(event)
        }
    }
    static let cards: [CreditCard] = [
        {
            let card = CreditCard(
                nickname: "Travel Rewards",
                cardholderName: "Alex Mercer",
                lastFourDigits: "1002",
                cardNetwork: .amex,
                issuerName: "American Express",
                expirationMonth: 8,
                expirationYear: 2027,
                billingDate: 15,
                paymentDueDate: 28,
                creditLimit: 25000,
                currentBalance: 3240.50,
                cardColor: "#1a237e",
                displayOrder: 0
            )
            return card
        }(),
        {
            let card = CreditCard(
                nickname: "Sapphire Preferred",
                cardholderName: "Alex Mercer",
                lastFourDigits: "4242",
                cardNetwork: .visa,
                issuerName: "Chase Bank",
                expirationMonth: 11,
                expirationYear: 2025,
                billingDate: 5,
                paymentDueDate: 20,
                creditLimit: 15000,
                currentBalance: 1240.00,
                cardColor: "#003d7a",
                displayOrder: 1,
                isPaidThisCycle: true
            )
            return card
        }(),
        {
            let card = CreditCard(
                nickname: "Daily Spending",
                cardholderName: "Alex Mercer",
                lastFourDigits: "8812",
                cardNetwork: .mastercard,
                issuerName: "Apple Card",
                expirationMonth: 3,
                expirationYear: 2028,
                billingDate: 1,
                paymentDueDate: 15,
                creditLimit: 10000,
                currentBalance: 38409.62,
                cardColor: "#2d2d2d",
                displayOrder: 2
            )
            return card
        }()
    ]

    static let securityEvents: [SecurityEvent] = [
        SecurityEvent(
            eventType: .encryptionUpdated,
            eventDescription: "Encryption Updated — RSA-4096 Key",
            riskLevel: .low,
            timestamp: Date().addingTimeInterval(-7200)
        ),
        SecurityEvent(
            eventType: .loginDetected,
            eventDescription: "New Login Detected",
            location: "San Francisco, CA",
            riskLevel: .medium,
            timestamp: Date().addingTimeInterval(-14400)
        ),
        SecurityEvent(
            eventType: .cardAdded,
            eventDescription: "New Card Added to Vault",
            riskLevel: .low,
            timestamp: Date().addingTimeInterval(-86400)
        )
    ]
}
