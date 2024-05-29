//
//  ProfileView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/17/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var name = ""
    @State private var characterLimit = 20
    
    @EnvironmentObject var x: X
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            VStack {
                Text("Leaderboard Name")
                    .font(.largeTitle)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                
                Text("Your score won't upload if your name is empty.")
                    .font(.subheadline)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundStyle(x.name.isEmpty ? Color(.systemRed) : Color(.systemGray))
                
                HStack {
                    TextField("\(characterLimit) Character Limit", text: $name)
                    
                    Text("\(name.count)/\(characterLimit)")
                }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                if name != x.name {
                    Button {
                        x.setName(newName: name)
                    } label: {
                        Text("Update Name")
                            .foregroundStyle(Color(.white))
                            .padding(10)
                            .background(Color(.systemBlue))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                    }
                } else {
                    Text("Update Name")
                        .foregroundStyle(Color(.white))
                        .padding(10)
                        .background(Color(.systemGray))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                if !x.name.isEmpty {
                    Button {
                        x.scoreUploadsAutomaticallyToggle()
                    } label: {
                        HStack {
                            Spacer()
                            
                            if x.scoreUploadsAutomatically {
                                Image(systemName: "checkmark.square.fill")
                                    .foregroundStyle(Color(.systemBlue))
                            } else {
                                Image(systemName: "square")
                                    .foregroundStyle(Color(.systemGray))
                            }
                            
                            Text("Automatically upload score.")
                                .font(.subheadline)
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundStyle(Color(.systemGray))
                            
                            Spacer()
                        }
                        .padding(.top)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            self.name = x.name
        }
        .onChange(of: name) { _ in
            if name.count > characterLimit {
                name = String(name.prefix(characterLimit))
            }
        }
    }
}

//#Preview {
//    ProfileView()
//}
