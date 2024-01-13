//
//  SignUpScreen.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct SignUpScreen: View {
    @StateObject private var manager = RegistrationManager()
    @State private var showPreviousButton: Bool = false
    
    var body: some View {
        ZStack {
            TabView(selection: $manager.active) {
                UsernameView(text: $manager.user.username, action: manager.next)
                    .tag(RegistrationManager.Screen.username)
                PasswordView(action: {
                    
                }, text: $manager.user.password, isSecure: $manager.isSecure)
                    .tag(RegistrationManager.Screen.password)
            }
            .animation(.easeInOut, value: manager.active)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
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
}
