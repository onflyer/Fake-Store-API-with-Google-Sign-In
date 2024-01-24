//
//  ValidationSecureField.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/24/24.
//

import SwiftUI

struct ValidationSecureField: View {
    
    enum EditState {
        case idle
        case firstTime
        case secondOrMore
    }
    @State private var editState: EditState = .idle
    @State private var height: CGFloat = 0
    @State private var isSecure: Bool = true
    @FocusState var isFocused:Bool
    
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
                ZStack {
                    if isSecure {
                        SecureField("", text: $text) {
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
                    } else {
                        TextField("", text: $text) {
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
                    }
                }
                .padding()
                .overlay(alignment: .trailing) {
                    Button(action: {
                                    isSecure.toggle()
                                }) {
                                    Image(systemName: isSecure ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                            
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isFocused ? Color.accentColor : Color(.secondarySystemBackground), lineWidth: 2)
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
                .background {
                    Color(.secondarySystemBackground)
                        .cornerRadius(5.0)
                        .shadow(radius: 5.0)
                }
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
    ValidationSecureField(placeholder: .constant("placeholder"), text: .constant("text"), errorText: .constant("errortext"), isValid: .constant(false))
}
