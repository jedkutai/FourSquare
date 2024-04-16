//
//  GameTarget.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/10/24.
//

import SwiftUI

struct GameTarget: View {
    let lightOn: Bool
    
    let frame: CGFloat = UIScreen.main.bounds.width / 2.2
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ZStack {
            Image(systemName: "square.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(colorScheme == .dark ? Color(.black) : Color(.white))
            
            Image(systemName: lightOn ? "square.fill" : "square")
                .resizable()
                .scaledToFit()
                .frame(width: frame, height: frame)
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
            
        }
        .frame(width: frame, height: frame)
        
    }
}

#Preview {
    GameTarget(lightOn: false)
}
