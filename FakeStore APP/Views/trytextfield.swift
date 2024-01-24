//
//  trytextfield.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/24/24.
//

import SwiftUI

struct trytextfield: View {
    @State var placeholder = "placeholder"
    @State var text = "text"
    @State var errror = "error"
    @State var isValid = false
    var body: some View {
        ValidationTextField(placeholder: $placeholder, text: $text, errorText: $errror, isValid: $isValid)
    }
}

#Preview {
    trytextfield()
}
