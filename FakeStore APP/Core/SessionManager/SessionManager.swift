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
        static let hasCompletedSignUpFlow = "hasCompletedSignUpFlow"
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
        UserDefaults.standard.setValue(true, forKey: UserDefaultKeys.hasCompletedSignUpFlow)
    }
    
    func completeOnboarding() {
        currentState = .signUp
        UserDefaults.standard.setValue(true, forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
    func configureCurrentState() {
        
        /**
         - User closes the app during the onboarding phase > Resume the app from the onboarding screens
         - User closes the app during the sign up phase > Resume the app from the sign up screens
         - User closes the app after viewing onboarding and sign up phase > Resume the app from the log in screen
         */
        
        let hasCompletedSignUpFlow = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasCompletedSignUpFlow)
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
        
        
        if hasCompletedSignUpFlow {
            currentState = .loggedOut
        } else {
            currentState = hasCompletedOnboarding ? .signUp : .onboarding
        }
    }
}
