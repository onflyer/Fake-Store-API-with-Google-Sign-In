//
//  OnboardingManager.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import Foundation

final class OnboardingManager: ObservableObject {
    
    @Published private(set) var items: [OnboardingItem] = []
    
    func load() {
        items = [.init(title: "Welcome to Fake Store Platzi"),
                 .init(title: "Feel free to browse")]
    }
}
