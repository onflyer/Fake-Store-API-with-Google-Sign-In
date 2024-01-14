//
//  User.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import Foundation

struct User {
    var name: String
    var email: String
    var password: String

    
    var avatarUrl: URL {
        return URL(string: "https://api.multiavatar.com/\(name).png")!
    }
}
