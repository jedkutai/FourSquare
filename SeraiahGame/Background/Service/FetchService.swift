//
//  FetchService.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/18/24.
//

import Foundation
import Firebase

struct FetchService {
    
    static func topScoresOneDay(limit: Int) async throws -> [Score] {
        var scores: [Score] = []
        
        let timeAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        
        let snapshot = try await Firestore.firestore().collection("leaderboard")
            .whereField("timestamp", isGreaterThan: timeAgo)
            .order(by: "score", descending: true)
            .limit(to: limit)
            .getDocuments()
        
        scores = snapshot.documents.compactMap({ try? $0.data(as: Score.self) })
        
        
        return scores
    }
    
    static func topScoresOneWeek(limit: Int) async throws -> [Score] {
        var scores: [Score] = []
        
        let timeAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        
        let snapshot = try await Firestore.firestore().collection("leaderboard")
            .whereField("timestamp", isGreaterThan: timeAgo)
            .order(by: "score", descending: true)
            .limit(to: limit)
            .getDocuments()
        
        scores = snapshot.documents.compactMap({ try? $0.data(as: Score.self) })
        
        return scores
    }
    
    static func topScoresOneMonth(limit: Int) async throws -> [Score] {
        var scores: [Score] = []
        
        let timeAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        
        let snapshot = try await Firestore.firestore().collection("leaderboard")
            .whereField("timestamp", isGreaterThan: timeAgo)
            .order(by: "score", descending: true)
            .limit(to: limit)
            .getDocuments()
        
        scores = snapshot.documents.compactMap({ try? $0.data(as: Score.self) })
        
        return scores
    }
}
