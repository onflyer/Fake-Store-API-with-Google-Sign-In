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
    @Published var isLoading: Bool = false
    
    
    func fetchProducts(endpointURL: EndPointEnum) async throws {
        let url = Resource(url: URL(string: endpointURL.path)!, method: .get([]), modelType: [ProductsResponseDTO].self )
        
        let productResults = try await httpClient.load(url)
        products = productResults

    }
    
    func loadProducts(endpointURL: EndPointEnum) async {
        do {
            self.isLoading = true
            try await self.fetchProducts(endpointURL: endpointURL)
            print(products)
            self.isLoading = false
        } catch {
            print(error)
        }
    }
}
