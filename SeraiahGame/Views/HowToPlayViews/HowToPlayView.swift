//
//  HowToPlayView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/10/24.
//

import SwiftUI

struct HowToPlayView: View {
    
    @Environment(\.colorScheme) var colorScheme
    let dimension = UIScreen.main.bounds.height / 3
    var body: some View {
        VStack {
            click
            
            Spacer()
            
            dontClick
            
            Spacer()
            
            Menu {
                Text("You can tap on a square multiple times when it's filled.")
            } label: {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: Defaults.iconDimension)
                    .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
            }
            
        }
        .padding()
    }
    
    var click: some View {
        VStack {
            Image(systemName: "square.fill")
                .resizable()
                .scaledToFit()
                .padding()
            
            Text("Tap")
                .font(.largeTitle.weight(.bold))
        }
        .frame(height: dimension)
        .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
    }
    
    var dontClick: some View {
        VStack {
            Image(systemName: "square")
                .resizable()
                .scaledToFit()
                .padding()
            
            Text("Don't Tap")
                .font(.largeTitle.weight(.bold))
        }
        .frame(height: dimension)
        .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
    }
}

#Preview {
    HowToPlayView()
}
