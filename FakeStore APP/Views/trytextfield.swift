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
    @State var isNotValid = false
    var body: some View {
        VStack {
            ValidationTextField(placeholder: $placeholder, text: $text, errorText: $errror, isValid: $isValid, isNotValid: $isNotValid)
            
            TextField("dasdas", text: $text)
            
        }
    }
}

#Preview {
    trytextfield()
}
