//
//  KeychainService.swift
//  CardVault
//

import Foundation
import Security

nonisolated struct KeychainService: Sendable {

    private static let serviceName = "com.cardvault.secrets"

    // MARK: - Card Number

    static func saveCardNumber(_ number: String, for cardId: UUID) -> Bool {
        save(data: Data(number.utf8), key: "card_number_\(cardId.uuidString)")
    }

    static func getCardNumber(for cardId: UUID) -> String? {
        guard let data = load(key: "card_number_\(cardId.uuidString)") else { return nil }
        return String(data: data, encoding: .utf8)
    }

    // MARK: - CVV

    static func saveCVV(_ cvv: String, for cardId: UUID) -> Bool {
        save(data: Data(cvv.utf8), key: "card_cvv_\(cardId.uuidString)")
    }

    static func getCVV(for cardId: UUID) -> String? {
        guard let data = load(key: "card_cvv_\(cardId.uuidString)") else { return nil }
        return String(data: data, encoding: .utf8)
    }

    // MARK: - Delete

    static func deleteSecrets(for cardId: UUID) {
        delete(key: "card_number_\(cardId.uuidString)")
        delete(key: "card_cvv_\(cardId.uuidString)")
    }

    // MARK: - Private Helpers

    @discardableResult
    private static func save(data: Data, key: String) -> Bool {
        // Try to update first
        let updateQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key,
        ]

        let updateAttributes: [String: Any] = [
            kSecValueData as String: data,
        ]

        let updateStatus = SecItemUpdate(updateQuery as CFDictionary, updateAttributes as CFDictionary)

        if updateStatus == errSecSuccess {
            return true
        }

        // If not found, add new
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
        ]

        let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
        return addStatus == errSecSuccess
    }

    private static func load(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess else { return nil }
        return result as? Data
    }

    @discardableResult
    private static func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key,
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}
