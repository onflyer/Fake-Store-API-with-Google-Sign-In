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
        ZStack {
        switch session.currentState {
        case .loggedIn:
            HomeScreen()
                .environmentObject(session)
                .transition(.opacity)
        case .loggedOut:
            LoginScreen()
                .environmentObject(session)
                .transition(.opacity)
        case .onboarding:
            OnboardingScreen(action: session.completeOnboarding)
                .transition(.opacity)
        default:
            Color.green.opacity(0.5).ignoresSafeArea()
            }
        }
        .animation(.easeInOut, value: session.currentState)
        .onAppear(perform: {
            session.configureCurrentState()
        })
    }
}

#Preview {
    MainAppScreen()
        .environmentObject(SessionManager())
}
