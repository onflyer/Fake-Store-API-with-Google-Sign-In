//
//  SignUpScreen.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct SignUpScreen: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var manager = RegistrationManager()
    @State private var showPreviousButton: Bool = false
    @State private var isRegistering: Bool = false
    
    
    var body: some View {
        ZStack {
            TabView(selection: $manager.active) {
                NameView(text: $manager.user.name, hasError: $manager.hasError) {
                    manager.validateName()
                    if !manager.hasError {
                        manager.next()
                    }
                }
                .tag(RegistrationManager.Screen.name)
                
                EmailView(text: $manager.user.email, hasError: $manager.hasError, action: {
                    manager.validateUsername()
                    if !manager.hasError {
                        manager.next()
                    }
                })
                    .tag(RegistrationManager.Screen.email)
                PasswordView(action: {
                    manager.validatePassword()
                    //TODO: HANDLE REGISTRATION
                    isRegistering = true
                    
                    Task {
                        try await Task.sleep(nanoseconds: 2_000_000_000)
                        isRegistering = false
                        session.register()
                    }
                
                }, text: $manager.user.password, isSecure: $manager.isSecure)
                    .tag(RegistrationManager.Screen.password)
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
            if newValue == RegistrationManager.Screen.allCases.first {
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
