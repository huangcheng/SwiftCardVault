//
//  BiometricService.swift
//  CardVault
//

import Foundation
import LocalAuthentication

nonisolated enum BiometricType: Sendable {
    case faceID
    case touchID
    case none
}

nonisolated struct BiometricService: Sendable {

    static func biometricType() -> BiometricType {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }

        switch context.biometryType {
        case .faceID:
            return .faceID
        case .touchID:
            return .touchID
        default:
            return .none
        }
    }

    static func authenticate() async -> Bool {
        let context = LAContext()
        let reason = String(localized: "Unlock The Vault to access your cards")

        do {
            let success = try await context.evaluatePolicy(
                .deviceOwnerAuthentication,
                localizedReason: reason
            )
            return success
        } catch {
            return false
        }
    }
}
