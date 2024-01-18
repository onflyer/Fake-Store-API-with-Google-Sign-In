//
//  RegistrationManager.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import Foundation

final class RegistrationManager: ObservableObject {
    
    enum Screen: Int,CaseIterable {
        case name
        case email
        case password
    }
    
    @Published var active: Screen = Screen.allCases.first!
    @Published var user = User(name: "", email: "", password: "")
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
    func validateName() {
        hasError = user.name.isEmpty
        error = user.name.isEmpty ? .emptyName : nil
    }
    
    func validateEmail() {
        hasError = user.email.isEmpty
        error = user.email.isEmpty ? .emptyUsername : nil
    }
    
    func validatePassword() {
        hasError = user.password.isEmpty || user.password.count < 4
        error = user.password.isEmpty || user.password.count < 4 ? .emptyPassword : nil
    }
    
    func fetchCreateUser() async {
        
    }
}

extension RegistrationManager {
    enum RegistrationError: LocalizedError {
        case emptyName
        case emptyUsername
        case emptyPassword
        
        var errorDescription: String? {
            switch self {
            case .emptyName:
                return "Name cannot be empty"
            case .emptyUsername:
                return "Username cannot be empty!!!"
            case .emptyPassword:
                return "Password cannot be empty!!!"
            
            }
        }
    }
}
