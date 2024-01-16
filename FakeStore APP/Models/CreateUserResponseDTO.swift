//
//  CreateUserErrorResponseDTO.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/16/24.
//

import Foundation

struct CreateUserErrorResponseDTO: Codable {
    let message: [String]
    let error: String
    let statusCode: Int
}

struct CreateUserSuccessResponseDTO: Codable {
    let email, password, name: String
    let avatar: String
    let role: String
    let id: Int
    let creationAt, updatedAt: String
    
}
