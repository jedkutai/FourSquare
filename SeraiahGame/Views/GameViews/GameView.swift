//
//  GameView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/8/24.
//

import SwiftUI
import Dispatch

enum GameState {
    case countdownScreen
    case gameScreen
    case gameOver
}

enum GameOverType {
    case none
    case misClick
    case timeExpired
}

struct GameView: View {
    
    @State private var gameState: GameState = .countdownScreen
    @State private var score: Int = 0
    
    @State private var originalTime: Int = 15
    @State private var timeRemaining: Int = 15
    
    @State private var targetReset: Bool = false
    @State private var gameOver: Bool = false
    
    @State private var topLeftTargetOn: Bool = false
    @State private var bottomLeftTargetOn: Bool = false
    @State private var topRightTargetOn: Bool = false
    @State private var bottomRightTargetOn: Bool = false
    
    @State private var reactionTimeArray: [Double] = []
    
    @State private var gameOverType: GameOverType = .none
    
    @EnvironmentObject var x: X
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            switch gameState {
                
            case .countdownScreen:
                CountdownScreenView(gameState: $gameState)
                
            case .gameScreen:
                PlayingView(gameState: $gameState, score: $score, originalTime: $originalTime, timeRemaining: $timeRemaining, targetReset: $targetReset, gameOver: $gameOver, topLeftTargetOn: $topLeftTargetOn, bottomLeftTargetOn: $bottomLeftTargetOn, topRightTargetOn: $topRightTargetOn, bottomRightTargetOn: $bottomRightTargetOn, reactionTimeArray: $reactionTimeArray, gameOverType: $gameOverType)
                
            case .gameOver:
                GameOverView(gameState: $gameState, score: $score, originalTime: $originalTime, timeRemaining: $timeRemaining, targetReset: $targetReset, gameOver: $gameOver, topLeftTargetOn: $topLeftTargetOn, bottomLeftTargetOn: $bottomLeftTargetOn, topRightTargetOn: $topRightTargetOn, bottomRightTargetOn: $bottomRightTargetOn, reactionTimeArray: $reactionTimeArray, gameOverType: $gameOverType)
            
            }
        }
            
    }
    
    
    
}

//#Preview {
//    GameView()
//}
