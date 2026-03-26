//
//  AddCardFormState.swift
//  CardVault
//

import SwiftUI

@Observable
final class AddCardFormState {
    var cardNumberRaw: String = "" {
        didSet {
            let digits = cardNumberRaw.filter(\.isNumber)
            if digits.count <= 19 {
                cardNumberRaw = digits
            } else {
                cardNumberRaw = String(digits.prefix(19))
            }
            autoDetectNetwork()
        }
    }

    var selectedNetwork: CardNetwork = .visa
    var cardholderName: String = ""
    var expiryText: String = "" {
        didSet {
            let digits = expiryText.filter(\.isNumber)
            if digits.count <= 4 {
                expiryText = digits
            } else {
                expiryText = String(digits.prefix(4))
            }
        }
    }
    var cvv: String = "" {
        didSet {
            let digits = cvv.filter(\.isNumber)
            if digits.count <= 4 {
                cvv = digits
            } else {
                cvv = String(digits.prefix(4))
            }
        }
    }
    var billingDate: Int = 1
    var paymentDueDate: Int = 15
    var currencyCode: String = "USD"
    var creditLimitText: String = ""
    var cardNumberError: String?
    var detectedNetwork: CardNetwork?

    static let supportedCurrencies = ["USD", "EUR", "GBP", "CNY", "JPY", "CAD", "AUD", "CHF", "HKD", "SGD"]

    var currencySymbol: String {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]))
        return locale.currencySymbol ?? "$"
    }

    var formattedCardNumber: String {
        let digits = cardNumberRaw
        var result = ""
        for (index, char) in digits.enumerated() {
            if index > 0 && index % 4 == 0 {
                result += " "
            }
            result.append(char)
        }
        return result
    }

    var formattedExpiry: String {
        let digits = expiryText
        if digits.count <= 2 {
            return digits
        }
        let month = String(digits.prefix(2))
        let year = String(digits.dropFirst(2))
        return "\(month)/\(year)"
    }

    var expiryMonth: Int {
        let digits = expiryText
        guard digits.count >= 2 else { return 1 }
        return Int(String(digits.prefix(2))) ?? 1
    }

    var expiryYear: Int {
        let digits = expiryText
        guard digits.count >= 4 else { return 2026 }
        return 2000 + (Int(String(digits.suffix(2))) ?? 26)
    }

    var lastFourDigits: String {
        let digits = cardNumberRaw
        if digits.count >= 4 {
            return String(digits.suffix(4))
        }
        return digits
    }

    var creditLimit: Decimal? {
        guard !creditLimitText.isEmpty else { return nil }
        let cleaned = creditLimitText.filter { $0.isNumber || $0 == "." }
        return Decimal(string: cleaned)
    }

    var isValid: Bool {
        !cardNumberRaw.isEmpty &&
        LuhnValidator.isValid(cardNumberRaw) &&
        !cardholderName.trimmingCharacters(in: .whitespaces).isEmpty &&
        expiryText.count == 4 &&
        expiryMonth >= 1 && expiryMonth <= 12 &&
        cvv.count >= 3
    }

    func validateCardNumber() {
        if cardNumberRaw.isEmpty {
            cardNumberError = nil
        } else if !LuhnValidator.isValid(cardNumberRaw) {
            cardNumberError = String(localized: "Invalid card number")
        } else {
            cardNumberError = nil
        }
    }

    private func autoDetectNetwork() {
        if let detected = CardNetworkDetector.detect(cardNumberRaw) {
            detectedNetwork = detected
            selectedNetwork = detected
        }
    }
}
