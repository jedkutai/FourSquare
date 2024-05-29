//
//  Score.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/16/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Score: Identifiable, Hashable, Codable {
    let id: String
    let score: Int
    let name: String
    var timestamp: Timestamp = Timestamp()
    
}
