//
//  MainMenuView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/6/24.
//

import SwiftUI

struct MainMenuView: View {
    
    @State private var lightOn: Bool = true
    @State private var showStatSheet: Bool = false
    
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    @EnvironmentObject var x: X
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
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
                
                Group {
                    NavigationLink {
                        GameView().navigationBarBackButtonHidden()
                    } label: {
                        Text("Start Game")
                    }
                    
                    NavigationLink {
                        HowToPlayView()
                    } label: {
                        Text("How to Play")
                    }
                    
                    NavigationLink {
                        ProfileView()
                    } label: {
                        HStack {
                            if x.name.isEmpty {
                                Text("*")
                                    .foregroundStyle(Color(.clear))
                            }
                            
                            Text("Options")
                            
                            if x.name.isEmpty {
                                Text("*")
                                    .foregroundStyle(Color(.systemBlue))
                            }
                        }
                    }
                    
                    NavigationLink {
                        LeaderBoardView()
                    } label: {
                        Text("Leaderboard")
                    }
                    
                }
                .font(.title.weight(.semibold))
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
                .padding(.top, 10)
                
                Spacer()
                Spacer()
                
//                Button {
//                    showStatSheet.toggle()
//                } label: {
//                    Image(systemName: "chart.bar.xaxis")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: Defaults.iconDimension)
//                        .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
//                        .padding(.bottom)
//                }
            }
        }
//        .sheet(isPresented: $showStatSheet) {
//            StatSheetView()
//        }
    }
}

//#Preview {
//    MainMenuView()
//}
