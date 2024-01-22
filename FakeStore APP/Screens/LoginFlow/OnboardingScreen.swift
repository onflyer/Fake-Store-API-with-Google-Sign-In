//
//  OnboardingScreen.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct OnboardingScreen: View {
    @StateObject private var manager = OnboardingManager()
    @State private var showButton = false
    let action: () -> Void
    
    var body: some View {
        ZStack {
            
            Color.green.opacity(0.5).ignoresSafeArea()
            
            if !manager.items.isEmpty {
                
                TabView {
                    
                    ForEach(manager.items) { item in
                        OnboardingView(item: item)
                            .onAppear {
                                if item == manager.items.last {
                                    withAnimation(.easeInOut) {
                                       showButton = true
                                    }
                                }
                            }
                            .overlay(alignment: .bottom) {
                                if showButton {
                                    Button("Next") {
                                        action()
                                    }
                                    .frame(width: 200, height: 56)
                                    .foregroundStyle(.green.opacity(0.5))
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .offset(y: 70)
                                    .transition(.scale.combined(with: .opacity))
                                    
                                
                                }
                                
                                

                            }
                        }
                    
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                

            }
        }
        .onAppear {
            manager.load()
        }
    }
        
}

#Preview {
    OnboardingScreen{}
}
