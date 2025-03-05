//
//  Item.swift
//  Trip
//
//  Created by j on 2025/03/05.
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
