//
//  LoginScreen.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct LoginScreen: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Image("logo")
                Text("Fake store")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                
                CustomTextField(text: $userName, placeholder: "Enter your usename")
                    .padding(.horizontal)
                
                CustomSecureField(text: $password, placeholder: "Enter your password")
                    .padding(.horizontal)
                
               
            }
        }

    }
}

#Preview {
    LoginScreen()
}
