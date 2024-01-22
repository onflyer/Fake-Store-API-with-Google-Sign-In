//
//  FirstOnboardingView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct OnboardingView: View {
    
    let item: OnboardingItem
    
    var body: some View {
        VStack {
            Text(item.title)
        }
       
    }
}

#Preview {
    OnboardingView(item: .init(title: "Preview item"))
}
