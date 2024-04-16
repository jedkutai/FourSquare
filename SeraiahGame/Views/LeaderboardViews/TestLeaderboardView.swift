//
//  TestLeaderboardView.swift
//  SeraiahGame
//
//  Created by Jed Kutai on 4/15/24.
//

import SwiftUI

struct TestLeaderboardView: View {
    var body: some View {
        Button {
            AuthService.getPlayer()
        } label: {
            Text("Print user")
        }
    }
}

#Preview {
    TestLeaderboardView()
}
