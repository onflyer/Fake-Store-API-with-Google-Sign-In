//
//  HomeScreenViewModel.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/22/24.
//

import Foundation

@MainActor
final class HomeScreenViewModel: ObservableObject {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
   @Published var products: [ProductsResponseDTO] = []
    
    
    func fetchProducts() async throws {
        let url = Resource(url: URL(string: EndPointEnum.All.path)!, method: .get([]), modelType: [ProductsResponseDTO].self )
        
        let productResults = try await httpClient.load(url)
        products = productResults
    }
    
    func loadProducts() async {
        do {
            try await self.fetchProducts()
            print(products)
        } catch {
            print(error)
        }
    }
}
