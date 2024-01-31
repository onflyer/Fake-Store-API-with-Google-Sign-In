//
//  ContentView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var session: SessionManager
    @State private var pickedCategory: EndPointEnum = .All
    init() {
      // Large Navigation Title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
   
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("darkblue").opacity(0.95).ignoresSafeArea()
                VStack {
                CustomPicker(pickedCategory: $pickedCategory)
                       
                       
                Spacer()
                        
                    
                    
                      
                    
                }
                .navigationTitle("Fake Store Platzi")
               
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            session.signOut()
                        }, label: {
                            Text("Log out")
                        })
                    }
            }
            }
        }

    }
}

#Preview {
    HomeScreen()
        .environmentObject(SessionManager())
}
