//
//  SessionManager.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum CurrentState {
        case loggedIn
        case loggedOut
    }
    
    @Published private (set) var currentState: CurrentState?
    
    func signIn() {
        currentState = .loggedIn
    }
    
    func signOut() {
        currentState = .loggedOut
    }
}
