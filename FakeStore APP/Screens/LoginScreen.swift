//
//  LoginScreen.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var session: SessionManager
    
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    var body: some View {
        
        
            Spacer()
            VStack(alignment: .center, spacing: 10) {
                    Text("Welcome")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundStyle(.black.opacity(0.3))
                    Image("logo")
                        .padding(.bottom)
                    
                    CustomTextField(text: $userName, placeholder: "Enter your usename")
                        .padding(.horizontal)
                    
                    CustomSecureField(text: $password, isSecure: $showPassword, placeholder: "Enter your password")
                        .padding(.horizontal)
                
                Button("Login") {
                    session.signIn()
                }
                .foregroundStyle(.white)
                .frame(width: 200, height: 56)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
                
                    
                   
            }
            Spacer()
      
        
        
        

    }
}

#Preview {
    LoginScreen()
        .environmentObject(SessionManager())
}
