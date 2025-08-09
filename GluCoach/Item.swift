//
//  Item.swift
//  GluCoach
//
//  Created by Camden Webster on 8/8/25.
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
