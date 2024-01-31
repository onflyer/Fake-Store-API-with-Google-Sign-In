//
//  ProductsResponseDTO.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/31/24.
//

import Foundation

struct ProductsResponseDTO: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
