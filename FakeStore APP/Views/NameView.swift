//
//  NameView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/14/24.
//

import SwiftUI

struct NameView: View {
    
    @Binding var text: String
    @Binding var hasError: Bool
    
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
                
                CustomTextField(text: $text, placeholder: "Please enter your name", hasError: $hasError)
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
    NameView(text: .constant("name"), hasError: .constant(false), action: {
        
    })
}
