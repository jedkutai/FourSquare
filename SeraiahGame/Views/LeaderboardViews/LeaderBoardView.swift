//
//  LeaderBoardView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/16/24.
//

import SwiftUI

enum LeaderBoardRange {
    case oneDay
    case oneWeek
    case oneMonth
}

struct LeaderBoardView: View {

    @State private var leaderBoardRange: LeaderBoardRange = .oneDay
    
    @State private var topScoresOneDay: [Score] = []
    @State private var topScoresOneWeek: [Score] = []
    @State private var topScoresOneMonth: [Score] = []
    
    private let scoreLimit: Int = 50
    
    @EnvironmentObject var x: X
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            VStack {
                
                Picker("", selection: $leaderBoardRange) {
                    Text("24 Hours")
                        .tag(LeaderBoardRange.oneDay)
                    
                    Text("7 Days")
                        .tag(LeaderBoardRange.oneWeek)
                    
                    Text("30 Days")
                        .tag(LeaderBoardRange.oneMonth)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                ScrollView(.vertical, showsIndicators: false) {
                    switch leaderBoardRange {
                    case .oneDay:
                        ForEach(Array(topScoresOneDay.enumerated()), id: \.0) { index, score in
                            LeaderboardScore(score: score, index: index)
                            
                            Divider()
                        }
                    case .oneWeek:
                        ForEach(Array(topScoresOneWeek.enumerated()), id: \.0) { index, score in
                            LeaderboardScore(score: score, index: index)
                            Divider()
                        }
                    case .oneMonth:
                        ForEach(Array(topScoresOneMonth.enumerated()), id: \.0) { index, score in
                            LeaderboardScore(score: score, index: index)
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
            }
            .navigationTitle("Leaderboard")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        StatSheetView()
                    } label: {
                        Image(systemName: "chart.bar.xaxis")
                            .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                    }
                }
            }
            .onAppear {
                onAppearActions()
            }
        }
    }
    
    private func onAppearActions() {
        getScores()
    }
    
    private func getScores() {
        Task {
            do {
                topScoresOneDay = try await FetchService.topScoresOneDay(limit: scoreLimit)
                topScoresOneWeek = try await FetchService.topScoresOneWeek(limit: scoreLimit)
                topScoresOneMonth = try await FetchService.topScoresOneMonth(limit: scoreLimit)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

//#Preview {
//    LeaderBoardView()
//}
