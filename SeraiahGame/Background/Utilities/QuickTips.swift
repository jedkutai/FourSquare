//
//  QuickTips.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/12/24.
//

import Foundation

struct QuickTips {
    static let randomMessages: [String] = [
        "Strangers By Nature - Adele",
        "Dream On - Aerosmith",
        "Ten Feet Tall - Afrojack",
        "Wow, I'm Not Crazy - AJR",
        "Real World - The All-American Rejects",
        "Get Away With It - Animal Kingdom",
        "House of the Rising Sun - The Animals",
        "Shooting Stars - Bag Raiders",
        "Dear Life - Beck",
        "Just the Two of Us",
        "Last Last - Burna Boy",
        "Daddy Lessons - Beyonce",
        "Deep End - Birdy",
        "Tighten Up - The Black Keys",
        "Till the World Ends - Britney Spears",
    ]
    
    static func getRandomMessage() -> String {
        var message: String = ""
        
        let range: Int = self.randomMessages.count - 1
        let randomIndex: Int = Int.random(in: 0...range)
        
        message = self.randomMessages[randomIndex]
        
        return message
    }
}
