//
//  PlayingView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/8/24.
//

import SwiftUI
import Dispatch

struct PlayingView: View {
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

    @State private var startTime: Date?
    @State private var stopTime: Date?
    @State private var canReact: Bool = false
    
    private let flipRate: Double = 0.75
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var x: X
    var body: some View {
        VStack {
            Ticker(originalTime: originalTime, timeRemaining: timeRemaining)

            
            Spacer()
            
            Text("\(score)")
                .font(.system(size: 150))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                .padding(.horizontal)
            
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    buttonPress(targetOn: topLeftTargetOn)
                } label: {
                    GameTarget(lightOn: topLeftTargetOn)
                }
                
                Button {
                    buttonPress(targetOn: topRightTargetOn)
                } label: {
                    GameTarget(lightOn: topRightTargetOn)
                }
                Spacer()
            }
            
            
            HStack {
                Spacer()
                Button {
                    buttonPress(targetOn: bottomLeftTargetOn)
                } label: {
                    GameTarget(lightOn: bottomLeftTargetOn)
                }
                
                Button {
                    buttonPress(targetOn: bottomRightTargetOn)
                } label: {
                    GameTarget(lightOn: bottomRightTargetOn)
                }
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Button {
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
            .padding(.bottom)
        }
        .onAppear {
            targetReset.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                timeRemaining -= 1
            }
        }
        .onChange(of: timeRemaining) { _ in
            updateTime()
        }
        .onChange(of: targetReset) { _ in
            if !canReact {
                if let stopTime = self.stopTime, let startTime = self.startTime {
                    let reactionTime: Double = Double(stopTime.timeIntervalSince(startTime))
                    reactionTimeArray.append(reactionTime)
                }
            }
            
            startTime = Date.now
            canReact = true
            
            changeTargets()
            
        }
        .onChange(of: gameOver) { _ in
            if gameOver {
                gameState = .gameOver
            }
            
        }
        
    }
    
    private func changeScore() {
        score += 1
    }
    
    private func coinFlip() -> Bool {
        return Bool.random()
    }
    
    private func changeTargets() {
        if !gameOver {
            DispatchQueue.main.asyncAfter(deadline: .now() + flipRate) {
                topLeftTargetOn = coinFlip()
                bottomLeftTargetOn = coinFlip()
                topRightTargetOn = coinFlip()
                bottomRightTargetOn = coinFlip()
                
                
                
                targetReset.toggle()
            }
        }
    }
    
    private func updateTime() {
        if timeRemaining > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                timeRemaining -= 1
            }
        } else {
            gameOverType = .timeExpired
            gameOver = true
        }
    }
    
    private func buttonPress(targetOn: Bool) {
        if !gameOver {
            if targetOn {
                changeScore()
                if canReact {
                    canReact = false
                    stopTime = Date.now
                }
            } else {
                gameOverType = .misClick
                gameOver = true
            }
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
}

//#Preview {
//    PlayingView()
//}
