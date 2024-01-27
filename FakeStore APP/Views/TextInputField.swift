//
//  TextInputField.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/24/24.
//

import SwiftUI

struct TextInputField: View {
    
    let placeholder: String
    
    @Binding var errorPrompt: AuthManager.RegistrationError?
    @Binding var isNotValid: Bool
    
    @Binding var text: String
    
    @State private var height: CGFloat = 0
    @FocusState var isFocused :Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .foregroundColor(text.isEmpty ? Color(.placeholderText) : .accentColor)
                    .offset(x: text.isEmpty ? 0 : -16, y: text.isEmpty ? 0 : -height * 0.85)
                    .scaleEffect(text.isEmpty ? 1: 0.9, anchor: .leading)
                    .padding()
                    .font(text.isEmpty ? .body: .body.bold())
                
                TextField("", text: $text)
                    .focused($isFocused)
                
                    .padding()
                
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isFocused ? Color.blue : Color(.secondarySystemBackground), lineWidth: 2)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isNotValid ? Color.red : Color.clear, lineWidth: 2)
                    )
                    .background(
                        GeometryReader { geometry in
                            Color(.clear).onAppear {
                                height = geometry.size.height
                            }
                        }
                    )
            }
            .background {
                Color(.secondarySystemBackground)
                    .cornerRadius(12.0)
                    .shadow(radius: (12.0))
            }
            .animation(.default, value: text.isEmpty)
            .animation(.default, value: isFocused)
            .animation(.default, value: isNotValid)
            
            if isNotValid {
                if let errorPrompt = errorPrompt?.errorDescription {
                    Text(errorPrompt)
                        .padding(.leading, 2)
                        .font(.footnote)
                        .foregroundColor(Color(.systemRed))
                    
                }
            }
        }
    }
}

#Preview {
    TextInputField(placeholder: "placeholder", errorPrompt: .constant(.emptyName), isNotValid: .constant(false), text: .constant("text") )
}
