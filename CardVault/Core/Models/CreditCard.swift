//
//  CreditCard.swift
//  CardVault
//

import Foundation
import SwiftData

@Model
final class CreditCard {
    var id: UUID = UUID()
    var nickname: String = ""
    var cardholderName: String = ""
    var lastFourDigits: String = ""
    var cardNetwork: CardNetwork = CardNetwork.visa
    var cardCategory: String = ""
    var issuerName: String = ""
    var expirationMonth: Int = 1
    var expirationYear: Int = 2026
    var billingDate: Int = 1
    var paymentDueDate: Int = 1
    var creditLimit: Decimal?
    var currentBalance: Decimal?
    var cardColor: String = "#3e90ff"
    var displayOrder: Int = 0
    var isPaidThisCycle: Bool = false
    var isLocked: Bool = false
    var createdAt: Date = Date()
    var updatedAt: Date = Date()

    init(
        nickname: String = "",
        cardholderName: String = "",
        lastFourDigits: String = "",
        cardNetwork: CardNetwork = .visa,
        cardCategory: String = "",
        issuerName: String = "",
        expirationMonth: Int = 1,
        expirationYear: Int = 2026,
        billingDate: Int = 1,
        paymentDueDate: Int = 1,
        creditLimit: Decimal? = nil,
        currentBalance: Decimal? = nil,
        cardColor: String = "#3e90ff",
        displayOrder: Int = 0,
        isPaidThisCycle: Bool = false,
        isLocked: Bool = false
    ) {
        self.id = UUID()
        self.nickname = nickname
        self.cardholderName = cardholderName
        self.lastFourDigits = lastFourDigits
        self.cardNetwork = cardNetwork
        self.cardCategory = cardCategory
        self.issuerName = issuerName
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
        self.billingDate = billingDate
        self.paymentDueDate = paymentDueDate
        self.creditLimit = creditLimit
        self.currentBalance = currentBalance
        self.cardColor = cardColor
        self.displayOrder = displayOrder
        self.isPaidThisCycle = isPaidThisCycle
        self.isLocked = isLocked
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
