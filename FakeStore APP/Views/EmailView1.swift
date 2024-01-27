//
//  EmailView1.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/27/24.
//

import SwiftUI

struct EmailView1: View {
    
    let placeholder: String
    @Binding var errorPrompt: AuthManager.RegistrationError?
    @Binding var isNotValid: Bool
    @Binding var text : String
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.5).ignoresSafeArea()
            VStack {
             Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
            Text("Email")
                    .font(.system(size: 30,weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                    TextInputField(placeholder: "Enter your email", errorPrompt: $errorPrompt, isNotValid: $isNotValid, text: $text)
                    .padding(.horizontal)
                
                Button("Next") {
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
    EmailView1(placeholder: "placeholder", errorPrompt: .constant(.emptyEmail), isNotValid: .constant(false), text: .constant("text"), action: {})
}
