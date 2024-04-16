//
//  StatSheetView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/10/24.
//

import SwiftUI

struct StatSheetView: View {
    @State private var lightOn: Bool = true
    @EnvironmentObject var x: X
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                lightOn.toggle()
            } label: {
                VStack {
                    HStack {
                        Target(lightOn: !lightOn)
                        
                        Target(lightOn: lightOn)
                    }
                    
                    HStack {
                        Target(lightOn: lightOn)
                        
                        Target(lightOn: !lightOn)
                    }
                }
                
            }
            
            Spacer()
            
            Text("Your High Score:")
                .font(.system(size: 150))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
            
            Text("\(x.highScore)")
                .font(.system(size: 150))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                .padding(.horizontal)
            
            Spacer()
            Spacer()
        }
        .padding()
    }
}

//#Preview {
//    StatSheetView()
//}
