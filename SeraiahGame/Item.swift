//
//  Item.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/6/24.
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
