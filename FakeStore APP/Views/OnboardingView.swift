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
        VStack(alignment: .center) {
                Text(item.title)
                    .foregroundStyle(.white)
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .multilineTextAlignment(.center)
            }
    }
}

#Preview {
    OnboardingView(item: .init(title: "Preview Item"))
}
