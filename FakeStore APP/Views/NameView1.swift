//
//  NameView1.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/27/24.
//

import SwiftUI

struct NameView1: View {
    
    let placeholder: String
    @Binding var errorPrompt: String
    @Binding var isNotValid: Bool
    @Binding var text : String
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.5).ignoresSafeArea()
            VStack {
             Image(systemName: "person.crop.circle.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
                    
            Text("Name")
                    .font(.system(size: 30,weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                ZStack {
                
                        TextInputField(placeholder: placeholder, errorPrompt: $errorPrompt, isNotValid: $isNotValid,text: $text)
                }
                .frame(height: 70)
              
               
                Button("Next") {
                    action()
                }
                .foregroundStyle(.green.opacity(0.5))
                .frame(width: 200, height: 56)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top)

                    }
                    .padding(.horizontal)
                
              
                
            
        }
    }
}

#Preview {
    NameView1(placeholder: "placeholder", errorPrompt: .constant("error"), isNotValid: .constant(false), text: .constant("text"), action: {})
}
