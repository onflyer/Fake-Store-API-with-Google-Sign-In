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
            Color("darkblue").opacity(0.95).ignoresSafeArea()
            VStack {
             Image(systemName: "person.crop.square.filled.and.at.rectangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100)
                    .foregroundStyle(Color("appgreen"))
                
            Text("Your email...")
                    .font(.system(size: 30,weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                ZStack {
                    TextInputField(placeholder: "Enter your email", errorPrompt: $errorPrompt, isNotValid: $isNotValid, text: $text)
                        .padding(.horizontal)
                }
                .frame(height: 50)
                
                Button("Next") {
                   action()
                }
                .foregroundStyle(.primary.opacity(0.5))
                .frame(width: 200, height: 56)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top, 20)
                
            }
        }
    }
}

#Preview {
    EmailView1(placeholder: "placeholder", errorPrompt: .constant(.emptyEmail), isNotValid: .constant(false), text: .constant("text"), action: {})
}
