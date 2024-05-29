//
//  GameOverView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/9/24.
//

import SwiftUI

enum UploadScoreState {
    case idle
    case uploading
    case success
    case failed
}

struct GameOverView: View {
    @Binding var gameState: GameState
    @Binding var score: Int
    
    @Binding var originalTime: Int
    @Binding var timeRemaining: Int
    
    @Binding var targetReset: Bool
    @Binding var gameOver: Bool
    
    @Binding var topLeftTargetOn: Bool
    @Binding var bottomLeftTargetOn: Bool
    @Binding var topRightTargetOn: Bool
    @Binding var bottomRightTargetOn: Bool
    
    @Binding var reactionTimeArray: [Double]
    
    @Binding var gameOverType: GameOverType
    
    @State private var uploadScoreState: UploadScoreState = .idle
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var x: X
    var body: some View {
        finalScore
    }
    
    var finalScore: some View {
        NavigationStack {
            VStack {
                Group {
                    if gameOverType == .misClick {
                        Text("Game Over")
                    } else if gameOverType == .timeExpired {
                        Text("Time's Up")
                    }
                }
                .font(.system(size: 30))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                
                Spacer()
                
                Group {
                    if score > x.highScore {
                        Text("New High Score!")
                    } else {
                        Text("Final Score")
                    }
                    
                    Text("\(score)")
                        
                }
                .font(.system(size: 150))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                
                Spacer()
                
                fastestTime
                
                Spacer()
                
                Group {
                    switch uploadScoreState {
                    case .idle:
                        Button {
                            uploadScore()
                        } label: {
                            Text("Upload Score")
                                .foregroundStyle(Color(.systemBlue))
                        }
                    case .uploading:
                        ProgressView("Uploading Score")
                    case .success:
                        Text("Score Uploaded")
                            .foregroundStyle(Color(.systemGray))
                    case .failed:
                        Button {
                            uploadScore()
                        } label: {
                            Text("Failed to upload. Try again.")
                                .foregroundStyle(Color(.systemBlue))
                        }
                    }
                }
                .font(.subheadline)
                
                Spacer()
                
                HStack {
                    Button {
                        x.setHighScore(score: score)
                        dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: Defaults.iconDimension)
                            .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                    }
                    Divider()
                    Button {
                        x.setHighScore(score: score)
                        restartGame()
                    } label: {
                        Image(systemName: "arrow.circlepath")
                            .resizable()
                            .scaledToFit()
                            .frame(height: Defaults.iconDimension)
                            .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                    }
                }
                .frame(height: 25)
                
            }
            .padding()
            .onAppear {
                onAppearActions()
            }
        }
    }
    
    var fastestTime: some View {
        VStack {
            Group {
                if let time = self.quickestReactionTime(reactionTimes: reactionTimeArray) {
                    Text("Quickest Reaction: \(time, specifier: "%.3f")")
                } else {
                    Text("Quickest Reaction: N/A")
                }
                
                if let time = self.averageReactionTime(reactionTimes: reactionTimeArray) {
                    Text("Average Reaction: \(time, specifier: "%.3f")")
                } else {
                    Text("Average Reaction: N/A")
                        
                }
            }
            .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
            .font(.system(size: 30))
            .minimumScaleFactor(0.01)
            .lineLimit(1)
            
        }
    }
    
    private func restartGame() {
        gameState = .countdownScreen
        score = 0
        timeRemaining = originalTime
        reactionTimeArray = []
        
        topLeftTargetOn = false
        bottomLeftTargetOn = false
        topRightTargetOn = false
        bottomRightTargetOn = false
        
        gameOverType = .none
        gameOver = false
    }
    
    private func averageReactionTime(reactionTimes: [Double]) -> Double? {
        var validTimes: Int = 0
        var totalTime: Double = 0
        
        for reactionTime in reactionTimes {
            if reactionTime > 0.1 {
                validTimes += 1
                totalTime += reactionTime
            }
        }
        
        if validTimes > 0 {
            let averageTime: Double = totalTime / Double(validTimes)
            return averageTime
        }
        
        return nil
    }
    
    private func quickestReactionTime(reactionTimes: [Double]) -> Double? {
        var fastestTime: Double?
        
        for reactionTime in reactionTimes {
            if reactionTime > 0.1 {
                if let fastestTimeUnwrapped = fastestTime {
                    if reactionTime < fastestTimeUnwrapped {
                        fastestTime = reactionTime
                    }
                } else {
                    fastestTime = reactionTime
                }
            }
        }
        
        return fastestTime
    }
    
    private func onAppearActions() {
        if !x.name.isEmpty {
            if x.scoreUploadsAutomatically {
                uploadScore()
            }
        }
    }
    
    private func uploadScore() {
        uploadScoreState = .uploading
        Task {
            do {
                try await LeaderboardService.uploadScore(score: score, name: x.name)
                uploadScoreState = .success
            } catch {
                uploadScoreState = .failed
            }
        }
    }
    
    
}

//#Preview {
//    GameOverView()
//}
