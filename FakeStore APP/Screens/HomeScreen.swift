//
//  ContentView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack {
            Text("Home screen")
            
            Button("Sign out") {
                
            }
            .foregroundStyle(.white)
                .frame(width: 200, height: 56)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 12))
              
            
        }
        .padding()
    }
}

#Preview {
    HomeScreen()
}
