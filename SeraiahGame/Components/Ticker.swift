//
//  Ticker.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/11/24.
//

import SwiftUI

struct Ticker: View {
    let originalTime: Int
    let timeRemaining: Int
    
    private let dimension = UIScreen.main.bounds.width
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ticker1
    }
    
    var ticker2: some View {
        HStack(spacing: 0) {
            Spacer()
            
            if timeRemaining > 0 {
                ForEach(1...timeRemaining, id: \.self) { _ in
                    Rectangle()
                        .frame(width: dimension / CGFloat(originalTime), height: 10)
                        .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                }
            }
            Spacer()
        }
        
    }
    
    var ticker1: some View {
        HStack {
            Spacer()
            
            if timeRemaining > 0 {
                ForEach(1...timeRemaining, id: \.self) { _ in
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: dimension / CGFloat(originalTime * 2))
                        .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                }
            }
            Spacer()
        }
    }
}

#Preview {
    Ticker(originalTime: 10, timeRemaining: 10)
}
