//
//  FakeStore_APPApp.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

@main
struct FakeStore_APPApp: App {
    
    static func main() async throws {
        let baseUrl = URL(string: "https://api.escuelajs.co/api/v1/products/25")

        var request = URLRequest(url: baseUrl!)
        request.httpMethod = "DELETE"
        

        let (data, _ ) = try! await URLSession.shared.data(for: request)

        let response = try! JSONDecoder().decode(DeleteProductResponseDTO.self, from: data)
        
        print(response)
    }
    
    
    @StateObject private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
          MainAppScreen()
                .environmentObject(session)
        }
    }
}
