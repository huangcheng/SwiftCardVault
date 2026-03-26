//
//  CardNetwork.swift
//  CardVault
//

import Foundation

enum CardNetwork: String, Codable, CaseIterable, Identifiable {
    case visa
    case mastercard
    case amex
    case unionpay
    case jcb
    case discover

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .visa: String(localized: "Visa")
        case .mastercard: String(localized: "Mastercard")
        case .amex: String(localized: "American Express")
        case .unionpay: String(localized: "UnionPay")
        case .jcb: String(localized: "JCB")
        case .discover: String(localized: "Discover")
        }
    }

    var sfSymbolName: String {
        switch self {
        case .visa: "creditcard"
        case .mastercard: "creditcard.fill"
        case .amex: "creditcard.trianglebadge.exclamationmark"
        case .unionpay: "creditcard.and.123"
        case .jcb: "creditcard"
        case .discover: "creditcard.fill"
        }
    }
}
