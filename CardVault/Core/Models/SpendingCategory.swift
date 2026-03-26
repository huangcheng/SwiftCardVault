//
//  SpendingCategory.swift
//  CardVault
//

import Foundation
import SwiftData

@Model
final class SpendingCategory {
    var id: UUID = UUID()
    var name: String = ""
    var amount: Decimal = 0
    var percentage: Double = 0
    var transactionCount: Int = 0
    var period: Date = Date()

    init(
        name: String = "",
        amount: Decimal = 0,
        percentage: Double = 0,
        transactionCount: Int = 0,
        period: Date = Date()
    ) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.percentage = percentage
        self.transactionCount = transactionCount
        self.period = period
    }
}
