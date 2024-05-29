//
//  ReportService.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/18/24.
//

import Foundation
import Firebase

struct ReportService {
    static func reportScore(score: Score) async throws {
        let reportDoc = Firestore.firestore().collection("reports").document()
        
        let docId = reportDoc.documentID
        
        let report = Report(id: docId, name: score.name)
        
        guard let encodedReport = try? Firestore.Encoder().encode(report) else { return }
        try? await reportDoc.setData(encodedReport)
    }
}
