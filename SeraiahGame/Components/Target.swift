//
//  Target.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/8/24.
//

import SwiftUI

struct Target: View {
    let lightOn: Bool
    
    let frame: CGFloat = UIScreen.main.bounds.height / 10
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        Image(systemName: lightOn ? "square.fill" : "square")
            .resizable()
            .scaledToFit()
            .frame(width: frame, height: frame)
            .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
        
    }
}

#Preview {
    Target(lightOn: false)
}
