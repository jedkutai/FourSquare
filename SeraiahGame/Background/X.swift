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
    
    @Published var name: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @Published var highScore: Int = UserDefaults.standard.integer(forKey: "highScore")
    @Published var scoreUploadsAutomatically: Bool = UserDefaults.standard.bool(forKey: "scoreUploadsAutomatically")
    
    @Published var firstOpen: Bool = true
    
    func setHighScore(score: Int) {
        if score > highScore {
            self.highScore = score
            UserDefaults.standard.set(score, forKey: "highScore")
        }
    }
    
    func setName(newName: String) {
        self.name = newName
        UserDefaults.standard.set(newName, forKey: "name")
    }
    
    func scoreUploadsAutomaticallyToggle() {
        self.scoreUploadsAutomatically.toggle()
        UserDefaults.standard.set(self.scoreUploadsAutomatically, forKey: "scoreUploadsAutomatically")
    }
    
}
