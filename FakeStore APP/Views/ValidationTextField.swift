//
//  ValidationTextField.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/24/24.
//

import SwiftUI

struct ValidationTextField: View {
    
    enum EditState {
        case idle
        case firstTime
        case secondOrMore
    }
    @State private var editState: EditState = .idle
    @State private var height: CGFloat = 0
    
    @FocusState var isFocused: Bool
    
    @Binding var placeholder: String
    @Binding var text: String
    @Binding var errorText: String
    @Binding var isValid: Bool
    
    var showValidationErrorPrompt: Bool {
        !isValid && (editState == .secondOrMore)
    }
    
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .foregroundColor(text.isEmpty ? Color(.placeholderText) : .accentColor)
                    .offset(x: text.isEmpty ? 0 : -16, y: text.isEmpty ? 0 : -height * 0.85)
                    .scaleEffect(text.isEmpty ? 1: 0.9, anchor: .leading)
                    .padding()
                    .font(text.isEmpty ? .body: .body.bold())
                TextField("", text: $text) { _ in
                    withAnimation(.default) { isFocused.toggle() }
                    switch editState {
                    case .idle:
                        editState = .firstTime
                    case .firstTime:
                        editState = .secondOrMore
                    case .secondOrMore:
                        break
                    }
                }
                .focused($isFocused)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isFocused ? Color.gray : Color(.secondarySystemBackground), lineWidth: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(showValidationErrorPrompt ? Color.red : Color.clear, lineWidth: 2)
                )
                .background(
                    GeometryReader { geometry in
                        Color(.clear).onAppear {
                            height = geometry.size.height
                        }
                    }
                )
            }
            .onTapGesture {
                isFocused = true
            }
            
                .background {
                    Color(.secondarySystemBackground)
                        .cornerRadius(5.0)
                        .shadow(radius: 5.0)
                }
                .animation(.default, value: isFocused)
                .animation(.default, value: text.isEmpty)
                .animation(.default, value: showValidationErrorPrompt)
                
                if showValidationErrorPrompt {
                    Text(errorText)
                        .padding(.leading, 2)
                        .font(.footnote)
                        .foregroundColor(Color(.systemRed))
                
            }
        }
    }
}

#Preview {
    ValidationTextField(placeholder: .constant("placeholder"), text: .constant("text"), errorText: .constant("error"), isValid: .constant(false))
}
