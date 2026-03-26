//
//  CardVaultTests.swift
//  CardVaultTests
//
//  Created by Cheng Huang on 2026-03-26.
//

import Testing
import Foundation
@testable import CardVault

// MARK: - Luhn Validator Tests

struct LuhnValidatorTests {

    @Test func validVisaNumber() {
        #expect(LuhnValidator.isValid("4111 1111 1111 1111"))
    }

    @Test func validMastercardNumber() {
        #expect(LuhnValidator.isValid("5500 0000 0000 0004"))
    }

    @Test func validAmexNumber() {
        #expect(LuhnValidator.isValid("3714 496353 98431"))
    }

    @Test func validNumberWithDashes() {
        #expect(LuhnValidator.isValid("4111-1111-1111-1111"))
    }

    @Test func validNumberNoSpaces() {
        #expect(LuhnValidator.isValid("4111111111111111"))
    }

    @Test func invalidNumber() {
        #expect(!LuhnValidator.isValid("4111 1111 1111 1112"))
    }

    @Test func nonNumericInput() {
        #expect(!LuhnValidator.isValid("abcd efgh ijkl mnop"))
    }

    @Test func emptyInput() {
        #expect(!LuhnValidator.isValid(""))
    }

    @Test func tooShortNumber() {
        #expect(!LuhnValidator.isValid("411"))
    }
}

// MARK: - Card Network Detector Tests

struct CardNetworkDetectorTests {

    @Test func detectVisa() {
        #expect(CardNetworkDetector.detect("4111111111111111") == .visa)
    }

    @Test func detectMastercard51to55() {
        #expect(CardNetworkDetector.detect("5111111111111118") == .mastercard)
    }

    @Test func detectMastercard2221to2720() {
        #expect(CardNetworkDetector.detect("2221000000000000") == .mastercard)
    }

    @Test func detectAmex34() {
        #expect(CardNetworkDetector.detect("341111111111111") == .amex)
    }

    @Test func detectAmex37() {
        #expect(CardNetworkDetector.detect("371449635398431") == .amex)
    }

    @Test func detectUnionPay62() {
        #expect(CardNetworkDetector.detect("6212345678901234") == .unionpay)
    }

    @Test func detectUnionPay81() {
        #expect(CardNetworkDetector.detect("8111111111111111") == .unionpay)
    }

    @Test func detectJCB() {
        #expect(CardNetworkDetector.detect("3528000000000000") == .jcb)
    }

    @Test func detectDiscover6011() {
        #expect(CardNetworkDetector.detect("6011111111111117") == .discover)
    }

    @Test func detectDiscover65() {
        #expect(CardNetworkDetector.detect("6500000000000000") == .discover)
    }

    @Test func unknownNetwork() {
        #expect(CardNetworkDetector.detect("9999999999999999") == nil)
    }

    @Test func emptyInput() {
        #expect(CardNetworkDetector.detect("") == nil)
    }

    @Test func partialVisaInput() {
        #expect(CardNetworkDetector.detect("41") == .visa)
    }
}

// MARK: - RiskLevel Tests

struct RiskLevelTests {

    @Test func lowLessThanMedium() {
        #expect(RiskLevel.low < RiskLevel.medium)
    }

    @Test func mediumLessThanHigh() {
        #expect(RiskLevel.medium < RiskLevel.high)
    }

    @Test func lowLessThanHigh() {
        #expect(RiskLevel.low < RiskLevel.high)
    }

    @Test func equalLevels() {
        #expect(!(RiskLevel.low < RiskLevel.low))
        #expect(!(RiskLevel.high < RiskLevel.high))
    }
}

// MARK: - CreditCard Model Tests

struct CreditCardModelTests {

    @Test func defaultValues() {
        let card = CreditCard()
        #expect(card.nickname == "")
        #expect(card.cardholderName == "")
        #expect(card.lastFourDigits == "")
        #expect(card.cardNetwork == .visa)
        #expect(card.cardCategory == "")
        #expect(card.issuerName == "")
        #expect(card.expirationMonth == 1)
        #expect(card.expirationYear == 2026)
        #expect(card.billingDate == 1)
        #expect(card.paymentDueDate == 1)
        #expect(card.creditLimit == nil)
        #expect(card.currentBalance == nil)
        #expect(card.cardColor == "#3e90ff")
        #expect(card.displayOrder == 0)
        #expect(card.isPaidThisCycle == false)
        #expect(card.isLocked == false)
    }

    @Test func customInitialization() {
        let card = CreditCard(
            nickname: "Chase Sapphire",
            cardholderName: "Alex Hamilton",
            lastFourDigits: "4242",
            cardNetwork: .visa,
            creditLimit: 25000,
            currentBalance: 1240
        )
        #expect(card.nickname == "Chase Sapphire")
        #expect(card.cardholderName == "Alex Hamilton")
        #expect(card.lastFourDigits == "4242")
        #expect(card.cardNetwork == .visa)
        #expect(card.creditLimit == 25000)
        #expect(card.currentBalance == 1240)
    }

    @Test func uniqueIDs() {
        let card1 = CreditCard()
        let card2 = CreditCard()
        #expect(card1.id != card2.id)
    }
}
