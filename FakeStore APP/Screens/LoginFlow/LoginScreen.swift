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
            Color("darkblue").opacity(0.95).ignoresSafeArea()
            VStack(alignment: .center, spacing: 10) {
                
                Image("logo")
                    .padding(.bottom)
                
                Text("Welcome")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
                    .offset(y: -20)
                
                VStack {
                    
                    
                    TextInputField(placeholder: "Enter your email", errorPrompt: $manager.validationError, isNotValid: $manager.isNotValid, text: $manager.login.email)
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                        
                    
                    TextInputSecureField(placeholder: "Enter your password", errorPrompt: $manager.loginError, isNotValid: $manager.isNotValid, isSecure: $manager.isSecure, text: $manager.login.password)
                        .padding(.horizontal)
                        
                        
                    
                    Button {
                        manager.validateLoginEmail()
                        manager.validateLoginPassword()
                        
                        print(manager.login)
                        if !manager.isNotValid && !manager.passNotValid {
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
                        
                    } label: {
                        Text("Login")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color("appgreen"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                if isRegistering {
                                ProgressView()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .background(Color("appgreen"))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 30)

                        
                    }

                }
            }
        }
    
        .alert(isPresented: $manager.hasError, error: manager.networkError) { error in
            Button("OK", role: .cancel) {
                
            }
        } message: { message in
            Text(message.message!)
        }


    }
}

#Preview {
    LoginScreen()
        .environmentObject(SessionManager())
}
