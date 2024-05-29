//
//  Report.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/18/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Report: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    var timestamp: Timestamp = Timestamp()
    
}
