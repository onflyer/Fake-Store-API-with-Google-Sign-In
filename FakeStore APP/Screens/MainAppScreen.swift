//
//  MainAppView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct MainAppScreen: View {
    @StateObject private var session = SessionManager()
    
    var body: some View {
        switch session.currentState {
        case .loggedIn:
            HomeScreen()
                .environmentObject(session)
                .transition(.opacity)
        default:
            LoginScreen()
                .environmentObject(session)
                .transition(.opacity)
        }
    }
}

#Preview {
    MainAppScreen()
}
