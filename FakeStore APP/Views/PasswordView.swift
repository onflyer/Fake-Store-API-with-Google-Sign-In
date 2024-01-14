//
//  PasswordView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct PasswordView: View {
    let action: () -> Void
    @Binding var text: String
    @Binding var isSecure: Bool
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.5).ignoresSafeArea()
            VStack {
             Image(systemName: "person.badge.key")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
            Text("Password")
                    .font(.system(size: 30,weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                CustomSecureField(text: $text, isSecure: $isSecure, placeholder: "Please enter a password")
                    .padding(.horizontal)
                    
                
                Button("Register") {
                   action()
                }
                .foregroundStyle(.green.opacity(0.5))
                .frame(width: 200, height: 56)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top)
                
            }
        }
    }
}

#Preview {
    PasswordView(action: {
        
    }, text: .constant(""), isSecure: .constant(true))
}
