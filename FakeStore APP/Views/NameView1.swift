//
//  NameView1.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/27/24.
//

import SwiftUI

struct NameView1: View {
    
    let placeholder: String
    @Binding var errorPrompt: AuthManager.RegistrationError?
    @Binding var isNotValid: Bool
    @Binding var text : String
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color("darkblue").opacity(0.95).ignoresSafeArea()
            VStack {
                ZStack {
                    Image(systemName: "person.crop.rectangle.badge.plus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 100)
                    .foregroundStyle(Color("appgreen"))
                }
                .offset(x: -10)
                .frame(maxWidth: .infinity)
                
                    
                    
            Text("What's your name")
                    .font(.system(size: 30,weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.center)
                
                ZStack {
                TextInputField(placeholder: placeholder, errorPrompt: $errorPrompt, isNotValid: $isNotValid,text: $text)
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
                    .padding(.horizontal)
                
              
                
            
        }
    }
}

#Preview {
    NameView1(placeholder: "placeholder", errorPrompt: .constant(.emptyName), isNotValid: .constant(false), text: .constant("text"), action: {})
}
