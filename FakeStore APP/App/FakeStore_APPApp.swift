//
//  FakeStore_APPApp.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

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
    
    
    @StateObject private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
          MainAppScreen()
                .environmentObject(session)
        }
    }
}
