//
//  X.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/6/24.
//

import SwiftUI
import Combine
import CoreLocation

@MainActor
class X: ObservableObject {
    
    // login stuff
    
    
    @Published var highScore: Int = UserDefaults.standard.integer(forKey: "highScore")
    
    @Published var firstOpen: Bool = true
    
    func setHighScore(score: Int) {
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(score, forKey: "highScore")
        }
    }
    
    
}
