//
//  CustomSecureField.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct CustomSecureField: View {
    
    @Binding var text: String
    @Binding var isSecure: Bool
    
    let placeholder: String
    
    @FocusState var focused: Bool
    
    var body: some View {
        let isActive = focused || text.count > 0
        
        ZStack(alignment: isActive ? .topLeading : .center) {
            ZStack {
                if isSecure {
                    SecureField("", text: $text)
                        
                } else {
                    TextField("", text: $text)
                }
            }
            .frame(height: 24)
            .font(.system(size: 16, weight: .regular))
            .opacity(isActive ? 1 : 0)
            .offset(y: 7)
            .focused($focused)
            
            HStack {
                Text(placeholder)
                    .foregroundColor(.black.opacity(0.3))
                    .frame(height: 16)
                    .font(.system(size: isActive ? 12 : 16, weight: .regular))
                    .offset(y: isActive ? -7 : 0)
                Spacer()
            }
        }
        .onTapGesture {
            focused = true
        }
        .animation(.linear(duration: 0.2), value: focused)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .background(.white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(focused ? .black.opacity(0.6) : .black.opacity(0.2), lineWidth: 2)
        }
        .overlay(alignment: .trailing) {
            Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    
        }
    }
}

#Preview {
    CustomSecureField(text: .constant("password"), isSecure: .constant(false), placeholder: "Enter your password")
}
