//
//  LeaderboardScore.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/18/24.
//

import SwiftUI

struct LeaderboardScore: View {
    let score: Score
    let index: Int
    
    @State private var showReportButton: Bool = false
    @State private var showReportAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    showReportButton = true
                }
            } label: {
                HStack {
                    Text("# \(index + 1)")
                        .frame(width: 50)
                        .foregroundColor(Color(.systemGray))
                        .fontWeight(.semibold)
                    
                    Text(score.name)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Spacer()
                    
                    Text("\(score.score)")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
            
            if showReportButton {
                Button {
                    showReportAlert.toggle()
                } label: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Color(.systemOrange))
                }
            }
        }
        .onChange(of: showReportButton) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    showReportButton = false
                }
            }
        }
        .alert(isPresented: $showReportAlert) {
            Alert(
                title: Text("Report Name"),
                message: Text("Are you sure that you want to report \"\(score.name)\"?"),
                primaryButton: .destructive(Text("Report")) {
                    Task {
                        do {
                            try await ReportService.reportScore(score: score)
                        } catch {
                            print("Report error: \(error.localizedDescription)")
                        }
                    }
                },
                secondaryButton: .cancel(Text("Cancel"))
            )

        }
        
    }
}

//#Preview {
//    LeaderboardScore()
//}
