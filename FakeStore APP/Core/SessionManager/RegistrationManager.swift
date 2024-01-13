//
//  RegistrationManager.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import Foundation

final class RegistrationManager: ObservableObject {
    
    enum Screen: Int,CaseIterable {
        case username
        case password
    }
    
    @Published var active: Screen = Screen.allCases.first!
    @Published var user = User(username: "", password: "")
    @Published var isSecure = true
    
    @Published var hasError: Bool = false
    @Published var error: RegistrationError?
    
    func next() {
        let nextScreenIndex = min(active.rawValue + 1, Screen.allCases.last!.rawValue)
        if let screen = Screen(rawValue: nextScreenIndex) {
            active = screen
        }
    }
    
    func previous() {
        let previousScreenIndex = max(active.rawValue - 1, Screen.allCases.first!.rawValue)
        if let screen = Screen(rawValue: previousScreenIndex) {
            active = screen
        }
    }
    
    func validateUsername() {
        hasError = user.username.isEmpty
        error = user.username.isEmpty ? .emptyUsername : nil
    }
    
    func validateBio() {
        hasError = user.password.isEmpty
        error = user.password.isEmpty ? .emptyPassword : nil
    }
}

extension RegistrationManager {
    enum RegistrationError: LocalizedError {
        case emptyUsername
        case emptyPassword
        
        var errorDescription: String? {
            switch self {
            case .emptyUsername:
                return "Username cannot be empty!!!"
            case .emptyPassword:
                return "Password cannot be empty!!!"
            }
        }
    }
}
