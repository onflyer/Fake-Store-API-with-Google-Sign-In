//
//  SessionManager.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//
import SwiftUI
import Foundation
import GoogleSignIn

final class SessionManager: ObservableObject {
    
    
      
       @Published var isLoggedIn: Bool = false
       @Published var errorMessage: String = ""
    
    func checkStatus() {
            if(GIDSignIn.sharedInstance.currentUser != nil){
                let user = GIDSignIn.sharedInstance.currentUser
                guard let user = user else { return }
                currentState = .loggedIn
            }else{
                currentState = .loggedOut
            }
        }
    
    func check() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if let error = error {
                    self.errorMessage = "error: \(error.localizedDescription)"
                }
                self.checkStatus()
            }
        }
    
    func googleSignIn() {
        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        let _ = GIDConfiguration.init(clientID: "CLIENT-ID")
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            self.checkStatus()
        }
       
    
    func googleSignOut(){
            GIDSignIn.sharedInstance.signOut()
            self.checkStatus()
        }
    }
    
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
