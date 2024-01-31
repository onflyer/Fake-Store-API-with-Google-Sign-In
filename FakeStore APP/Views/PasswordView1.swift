//
//  PasswordView1.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/28/24.
//

import SwiftUI

struct PasswordView1: View {
    let placeholder: String
    @Binding var errorPrompt: AuthManager.RegistrationError?
    @Binding var isNotValid: Bool
    @Binding var isSecure: Bool
    @Binding var text : String
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color("darkblue").opacity(0.95).ignoresSafeArea()
            VStack {
             Image(systemName: "lock.open.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100)
                    .foregroundStyle(Color("appgreen"))
                
            Text("Your password")
                    .font(.system(size: 30,weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                ZStack {
                    TextInputSecureField(placeholder: "Enter your password", errorPrompt: $errorPrompt, isNotValid: $isNotValid, isSecure: $isSecure, text: $text)
                        .padding(.horizontal)
                }
                .frame(height: 50)
                    
                
                Button("Register") {
                   action()
                }
                .frame(width: 200, height: 56)
                .foregroundStyle(.primary.opacity(0.5))
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top, 20)
                
                
            }
        }
    }
}

#Preview {
    PasswordView1(placeholder: "placeholder", errorPrompt: .constant(.emptyPassword), isNotValid: .constant(true), isSecure: .constant(false), text: .constant("text"), action: {})
}
