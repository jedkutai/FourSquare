//
//  LeaderboardService.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/17/24.
//

import Foundation
import Firebase

struct LeaderboardService {
    
    static func uploadScore(score: Int, name: String) async throws {
        let leaderboardDoc = Firestore.firestore().collection("leaderboard").document()
        let docId = leaderboardDoc.documentID
        
        let score = Score(id: docId, score: score, name: name)
        
        guard let encodedScore = try? Firestore.Encoder().encode(score) else { return }
        try? await leaderboardDoc.setData(encodedScore)
    }
}
