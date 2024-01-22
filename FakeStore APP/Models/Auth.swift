//
//  Auth.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/18/24.
//

import Foundation

struct LoginResponseDTO: Codable {
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

struct GetNewAccessToken: Codable {
    let refreshToken : String
}

struct LoginUser: Codable {
    var email: String
    var password: String
}
