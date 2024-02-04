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
    @Published var login = LoginUser(email: "", password: "")
    @Published var isSecure = true
    @Published var isNotValid = false
    @Published var passNotValid = false
    
    @Published var hasError: Bool = false
    @Published var validationError: RegistrationError?
    @Published var loginError: LoginError?
   

    
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
        isNotValid = user.name.isEmpty
        validationError = user.name.isEmpty ? .emptyName : nil
    }
    
    func validateEmail() {
        isNotValid = user.email.isEmpty || !user.email.isValidEmail
        if user.email.isEmpty {
            validationError = .emptyEmail
        } else if !user.email.isValidEmail {
            validationError = .notAnEmail
        } else {
            validationError = nil
        }
    }
    
    func validateLoginEmail()  {
        isNotValid = login.email.isEmpty || !login.email.isValidEmail
        if login.email.isEmpty {
            validationError = .emptyEmail
        } else if !login.email.isValidEmail {
            validationError = .notAnEmail
        } else {
            validationError = nil
        }

    }
    
    func validateLoginPassword() {
        passNotValid = login.password.isEmpty || login.password.count < 4
        if login.password.isEmpty {
            loginError = .emptyPassword
        } else if login.password.count < 4 {
            loginError = .passwordLessThan4
        } else {
            loginError = nil
        }
    }
    
    func validatePassword() {
        isNotValid = user.password.isEmpty || user.password.count < 4
        if user.password.isEmpty {
            loginError = .emptyPassword
        } else if user.password.count < 4 {
            loginError = .passwordLessThan4
        } else {
            loginError = nil
        }
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
    
    func fetchLogin() async throws {
        
        let data = login
        
        let resource = try Resource(url: Endpoint.Urls.login, method: .post(JSONEncoder().encode(data)), modelType: LoginResponseDTO.self)
        
        let loggedInUser = try await httpClient.load(resource)
        print(loggedInUser)
    }
    
    func login() async throws {
        do {
            try await fetchLogin()
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
        case passwordLessThan4
        case notAnEmail
        
        var errorDescription: String? {
            switch self {
            case .emptyName:
                return "Name cannot be empty!!!"
            case .emptyEmail:
                return "Email cannot be empty!!!"
            case .emptyPassword:
                return "Password cannot be empty!!!"
            case .notAnEmail:
                return "Email must be in correct format!!!"
            case .passwordLessThan4:
                return "Password must contain at least 4 characters"
            }
        }
    }
    
    enum LoginError: LocalizedError {
        case emptyName
        case emptyEmail
        case emptyPassword
        case passwordLessThan4
        case notAnEmail
        
        var errorDescription: String? {
            switch self {
            case .emptyName:
                return "Name cannot be empty!!!"
            case .emptyEmail:
                return "Email cannot be empty!!!"
            case .emptyPassword:
                return "Password cannot be empty!!!"
            case .notAnEmail:
                return "Email must be in correct format!!!"
            case .passwordLessThan4:
                return "Password must contain at least 4 characters"
            }
        }
    }
}
