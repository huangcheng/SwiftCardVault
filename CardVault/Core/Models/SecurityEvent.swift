//
//  SecurityEvent.swift
//  CardVault
//

import Foundation
import SwiftData

enum SecurityEventType: String, Codable {
    case loginDetected
    case encryptionUpdated
    case biometricChanged
    case cardAdded
    case cardDeleted
    case cardLocked
    case cardUnlocked
    case exportPerformed
    case importPerformed
}

enum RiskLevel: String, Codable, Comparable {
    case low
    case medium
    case high

    private var sortOrder: Int {
        switch self {
        case .low: 0
        case .medium: 1
        case .high: 2
        }
    }

    static func < (lhs: RiskLevel, rhs: RiskLevel) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}

@Model
final class SecurityEvent {
    var id: UUID = UUID()
    var eventType: SecurityEventType = SecurityEventType.loginDetected
    var eventDescription: String = ""
    var location: String?
    var riskLevel: RiskLevel = RiskLevel.low
    var timestamp: Date = Date()

    init(
        eventType: SecurityEventType = SecurityEventType.loginDetected,
        eventDescription: String = "",
        location: String? = nil,
        riskLevel: RiskLevel = RiskLevel.low,
        timestamp: Date = Date()
    ) {
        self.id = UUID()
        self.eventType = eventType
        self.eventDescription = eventDescription
        self.location = location
        self.riskLevel = riskLevel
        self.timestamp = timestamp
    }
}
