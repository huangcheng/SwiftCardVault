//
//  LuhnValidator.swift
//  CardVault
//

import Foundation

nonisolated struct LuhnValidator: Sendable {

    static func isValid(_ cardNumber: String) -> Bool {
        let digits = cardNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        guard !digits.isEmpty else { return false }
        guard digits.count >= 12 && digits.count <= 19 else { return false }

        var sum = 0
        let reversed = digits.reversed().map { Int(String($0))! }

        for (index, digit) in reversed.enumerated() {
            if index % 2 == 1 {
                let doubled = digit * 2
                sum += doubled > 9 ? doubled - 9 : doubled
            } else {
                sum += digit
            }
        }

        return sum % 10 == 0
    }
}
