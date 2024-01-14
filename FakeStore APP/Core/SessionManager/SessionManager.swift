//
//  SessionManager.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum UserDefaultKeys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
    }
    
    enum CurrentState {
        case loggedIn
        case loggedOut
        case onboarding
        case signUp
    }
    
    @Published private (set) var currentState: CurrentState?
    
    func signIn() {
        currentState = .loggedIn
    }
    
    func signOut() {
        currentState = .loggedOut
    }
    func register() {
        //MARK: API CALL FUNCTION FOR LOGIN
        signIn()
    }
    
    func completeOnboarding() {
        currentState = .signUp
        UserDefaults.standard.setValue(true, forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
    func configureCurrentState() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
        
        if hasCompletedOnboarding {
            currentState = .loggedOut
        } else {
            currentState = .onboarding
        }
    }
}
