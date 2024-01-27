//
//  SignUpScreen.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct SignUpScreen: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var manager = AuthManager(httpClient: HTTPClient())
    @State private var showPreviousButton: Bool = false
    @State private var isRegistering: Bool = false
    
    
    var body: some View {
        ZStack {
            TabView(selection: $manager.active) {
                NameView1(placeholder: "Please enter your name", errorPrompt: $manager.errorPrompt, isNotValid: $manager.isNotValid, text: $manager.user.name, action: {
                    manager.validateName()
                    if !manager.isNotValid {
                        manager.next()
                    }
                })
                .tag(AuthManager.Screen.name)
                .onChange(of: manager.user.name) {
                    manager.validateName()
                }
                
                EmailView(text: $manager.user.email, hasError: $manager.hasError, action: {
                    manager.validateEmail()
                    if !manager.hasError {
                        manager.next()
                    }
                })
                    .tag(AuthManager.Screen.email)
                
                PasswordView(text: $manager.user.password, isSecure: $manager.isSecure, hasError: $manager.hasError) {
                    manager.validatePassword()
                    
                    print(manager.user)
                    if !manager.hasError {
                        isRegistering = true
                        Task {
                            try await manager.loadCreateUser()
                            isRegistering = false
                            guard !manager.hasError else {
                                return
                            }
                            session.register()
                        }
                    }
                }
                .tag(AuthManager.Screen.password)
                
            }
            .animation(.easeInOut, value: manager.active)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .overlay {
            if isRegistering {
                Color.black.opacity(0.4).ignoresSafeArea()
                ProgressView()
                    .tint(.white)
            }
        }
        .animation(.easeInOut, value: isRegistering)

        .ignoresSafeArea()
        .overlay(alignment: .topLeading, content: {
            if showPreviousButton {
                Button(action: {
                    manager.previous()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .symbolVariant(.circle.fill)
                        .foregroundStyle(.white)
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .padding()
            })
            }
        })
        .animation(.easeInOut, value: showPreviousButton)
        .onAppear {
            UIScrollView.appearance().isScrollEnabled = false
        }
        .onDisappear {
            UIScrollView.appearance().isScrollEnabled = true
        }
        .onChange(of: manager.active) { oldValue, newValue in
            if newValue == AuthManager.Screen.allCases.first {
                showPreviousButton = false
            } else {
                showPreviousButton = true
            }
        }
        
    }
}

#Preview {
    SignUpScreen()
        .environmentObject(SessionManager())
}
