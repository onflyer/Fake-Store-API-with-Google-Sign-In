//
//  LoginScreen.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var manager = AuthManager(httpClient: HTTPClient())
    @State private var isRegistering = false
    
    

    var body: some View {
        
        ZStack {
            Color.clear.ignoresSafeArea()
        VStack(alignment: .center, spacing: 10) {
            Text("Welcome")
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundStyle(.black.opacity(0.3))
            Image("logo")
                .padding(.bottom)
            
            TextInputField(placeholder: "Enter your email", errorPrompt: $manager.validationError, isNotValid: $manager.isNotValid, text: $manager.login.email)
                .padding(.horizontal)
            
            TextInputSecureField(placeholder: "Enter your password", errorPrompt: $manager.validationError, isNotValid: $manager.isNotValid, isSecure: $manager.isSecure, text: $manager.login.password)
                .padding(.horizontal)
            
            Button("Login") {
                manager.validateLoginEmail()
                manager.validateLoginPassword()
                
                print(manager.login)
                if !manager.isNotValid {
                    isRegistering = true
                    Task {
                        try await manager.login()
                        isRegistering = false
                        guard !manager.hasError else {
                            return
                        }
                        session.signIn()
                    }
                }
            }
            .foregroundStyle(.white)
            .frame(width: 200, height: 56)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
        }
        
        
        
        
        
    }
        .overlay {
            if isRegistering {
                Color.black.opacity(0.4).ignoresSafeArea()
                ProgressView()
                    .tint(.white)
            }
        }
        .animation(.easeInOut, value: isRegistering)

    }
}

#Preview {
    LoginScreen()
        .environmentObject(SessionManager())
}
