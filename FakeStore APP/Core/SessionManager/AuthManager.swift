//
//  RegistrationManager.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import Foundation

@MainActor
final class AuthManager: ObservableObject {
    
    let httpClient: HTTPClient
    
    enum Screen: Int,CaseIterable {
        case name
        case email
        case password
    }
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    @Published var active: Screen = Screen.allCases.first!
    @Published var user = User(name: "", email: "", password: "")
    @Published var isSecure = true
    
    @Published var hasError: Bool = false
    @Published var error: RegistrationError?

    
    @Published var networkError: NetworkError?
    
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
        hasError = user.email.isEmpty || !user.email.isValidEmail
        error = user.email.isEmpty ? .emptyEmail : nil
    }
    
    func validatePassword() {
        hasError = user.password.isEmpty || user.password.count < 4
        error = user.password.isEmpty || user.password.count < 4 ? .emptyPassword : nil
    }
    
    func createUser() async throws {
        
        let data = user
        
        let resource = try Resource(url: Endpoint.Urls.createUser, method: .post(JSONEncoder().encode(data)), modelType: CreateUserSuccessResponseDTO.self)
        
        let newUser = try await httpClient.load(resource)
        print(newUser)
    }
    
    func loadCreateUser() async throws {
        do {
            try await createUser()
        } catch {
            print(error)
            self.hasError = true
            if let networkingError = error as? NetworkError {
                self.networkError = networkingError
            } else {
                self.networkError = .custom(error: error)
            }
            
        }
    }
}

extension AuthManager {
    enum RegistrationError: LocalizedError {
        case emptyName
        case emptyEmail
        case emptyPassword
        
        var errorDescription: String? {
            switch self {
            case .emptyName:
                return "Name cannot be empty"
            case .emptyEmail:
                return "Username cannot be empty!!!"
            case .emptyPassword:
                return "Password cannot be empty and must contain at least 4 characters!!!"
            
            }
        }
    }
}
