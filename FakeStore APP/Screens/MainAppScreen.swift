//
//  MainAppView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct MainAppScreen: View {
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        ZStack {
        switch session.currentState {
        case .loggedIn:
            HomeScreen()
                .transition(.opacity)
        case .loggedOut:
            LoginScreen()
                .transition(.opacity)
        case .onboarding:
            OnboardingScreen(action: session.completeOnboarding)
                .transition(.opacity)
        case .signUp:
            SignUpScreen()
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
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
