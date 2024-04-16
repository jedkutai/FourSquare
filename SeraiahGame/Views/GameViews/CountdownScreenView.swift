//
//  CountdownScreenView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/8/24.
//

import SwiftUI

struct CountdownScreenView: View {
    @Binding var gameState: GameState
    @State private var time: Int = 3
    
    private let interval: Double = 0.5
//    private let randomMessage: String = QuickTips.getRandomMessage()
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Spacer()
            
            Text(time > 0 ? "\(time)" : "")
                .font(.system(size: 200))
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                
            Spacer()
            
//            Text(randomMessage)
//                .multilineTextAlignment(.center)
//                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                time -= 1
                DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                    time -= 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                        time -= 1
                        gameState = .gameScreen
                    }
                }
            }
        }
    }
}

//#Preview {
//    CountdownScreenView()
//}
