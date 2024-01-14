//
//  UsernameView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct EmailView: View {
    @Binding var text: String
    @Binding var hasError: Bool
    
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
                
                CustomTextField(text: $text, placeholder: "Please enter an email", hasError: $hasError)
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
    EmailView(text: .constant(""), hasError: .constant(true)) {
        
    }
}
