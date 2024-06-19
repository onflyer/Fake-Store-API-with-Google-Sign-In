//
//  FakeStore_APPApp.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI
import GoogleSignIn

@main
struct FakeStore_APPApp: App {
    
    //    static func main() async throws {
    //        let baseUrl = URL(string: "https://api.escuelajs.co/api/v1/products/49")
    //
    //        var request = URLRequest(url: baseUrl!)
    //        request.httpMethod = "DELETE"
    //
    //
    //        let (data, _ ) = try await URLSession.shared.data(for: request)
    //
    //        do {
    //          let response =  try JSONDecoder().decode(DeleteProductSuccessResponseDTO.self, from: data)
    //          print(response)
    //        } catch {
    //            let error = try JSONDecoder().decode(DeleteProductErrorResponseDTO.self, from: data)
    //            print(error)
    //        }
    //
    //    }
    
    //        static func main() async throws {
    //            let baseUrl = URL(string: "https://api.escuelajs.co/api/v1/users/")
    //
    //            var request = URLRequest(url: baseUrl!)
    //            request.httpMethod = "POST"
    //
    //            let user = User(name: "sssssss", email: "sssssssss@email.com", password: "sssssss")
    //            print(user)
    //            let newUser =  try JSONEncoder().encode(user)
    //            request.addValue("application/json",forHTTPHeaderField: "Content-Type")
    //            request.addValue("application/json",forHTTPHeaderField: "Accept")
    //
    //            request.httpBody = newUser
    //
    //            let (data, _ ) = try await URLSession.shared.data(for: request)
    //
    //            do {
    //                let response = try JSONDecoder().decode(CreateUserSuccessResponseDTO.self, from: data)
    //                print(response)
    //            } catch {
    //                let error = try JSONDecoder().decode(CreateUserErrorResponseDTO.self, from: data)
    //                print(error)
    //            }
    //
    //        }
    
    
    @StateObject private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            MainAppScreen()
                .environmentObject(session)
        }
    }
}
