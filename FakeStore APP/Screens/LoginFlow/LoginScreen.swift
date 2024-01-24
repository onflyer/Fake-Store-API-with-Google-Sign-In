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
            
            CustomTextField(text: $manager.login.email, placeholder: "Enter your email", hasError: $manager.hasError )
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(manager.hasError ? .red.opacity(0.6) : .black.opacity(0.0), lineWidth: 2)
                    if manager.hasError {
                        Text("Email cannot be empty and must be valid email")
                            .foregroundStyle(.red.opacity(0.6))
                            .font(.footnote)
                            .offset(x: -81, y: 37)
                    }
                }
                .padding(.horizontal)
            
            CustomSecureField(text: $manager.login.password, isSecure: $manager.isSecure, hasError: $manager.hasError, placeholder: "Enter your password")
                .padding(.horizontal)
            
            Button("Login") {
                manager.validateLoginEmail()
                manager.validateLoginPassword()
                
                print(manager.login)
                if !manager.hasError {
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
