//
//  Item.swift
//  CardVault
//
//  Created by Cheng Huang on 2026-03-26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
