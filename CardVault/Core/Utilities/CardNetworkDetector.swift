//
//  CardNetworkDetector.swift
//  CardVault
//

import Foundation

nonisolated struct CardNetworkDetector: Sendable {

    static func detect(_ cardNumber: String) -> CardNetwork? {
        let digits = cardNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        guard !digits.isEmpty else { return nil }

        // Amex: starts with 34 or 37
        if digits.hasPrefix("34") || digits.hasPrefix("37") {
            return .amex
        }

        // Visa: starts with 4
        if digits.hasPrefix("4") {
            return .visa
        }

        // Mastercard: 51-55 or 2221-2720
        if digits.count >= 2 {
            let first2 = Int(String(digits.prefix(2)))!
            if first2 >= 51 && first2 <= 55 {
                return .mastercard
            }
            if digits.count >= 4 {
                let first4 = Int(String(digits.prefix(4)))!
                if first4 >= 2221 && first4 <= 2720 {
                    return .mastercard
                }
            }
        }

        // Discover: 6011, 622126-622925, 644-649, 65
        if digits.hasPrefix("6011") || digits.hasPrefix("65") {
            return .discover
        }
        if digits.count >= 3 {
            let first3 = Int(String(digits.prefix(3)))!
            if first3 >= 644 && first3 <= 649 {
                return .discover
            }
        }
        if digits.count >= 6 {
            let first6 = Int(String(digits.prefix(6)))!
            if first6 >= 622126 && first6 <= 622925 {
                return .discover
            }
        }

        // UnionPay: starts with 62 or 81 (check after Discover's 622126-622925)
        if digits.hasPrefix("62") || digits.hasPrefix("81") {
            return .unionpay
        }

        // JCB: 3528-3589
        if digits.count >= 4 {
            let first4 = Int(String(digits.prefix(4)))!
            if first4 >= 3528 && first4 <= 3589 {
                return .jcb
            }
        }

        return nil
    }
}
