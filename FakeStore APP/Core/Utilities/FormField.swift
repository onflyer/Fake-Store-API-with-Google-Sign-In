//
//  FormField.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/24/24.
//

import Foundation

struct FormField: Validatable {
    
    var validate: (String) -> Bool
    
    var text: String
    let placeholder: String
    let prompt: String
    
    init(text: String = "", placeholder: String, prompt: String, validate: @escaping (String) -> Bool) {
        self.text = text
        self.validate = validate
        self.prompt = prompt
        self.placeholder = placeholder
    }
}

protocol Validatable {
    var text: String { get }
    var validate: (String) -> Bool { get }
}

extension Validatable {
    
    var isValid: Bool {
        validate(text)
    }
}

extension Collection where Element: Validatable {
    var isValid: Bool {
        self.allSatisfy { $0.isValid }
    }
}
