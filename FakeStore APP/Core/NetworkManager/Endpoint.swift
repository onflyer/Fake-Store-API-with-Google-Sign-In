//
//  Endpoint.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/16/24.
//

import Foundation

struct Endpoint {
    
    private static let baseUrl = "https://api.escuelajs.co/api/v1"
    
    struct Urls {
        static let getAllProducts = URL(string: "\(baseUrl)/products")!
        static func getOneProduct(productId: Int) -> URL {
            return URL(string: "\(baseUrl)/products/\(productId)")!
        }
        static let createProduct = URL(string: "\(baseUrl)/products")!
        static func updateProduct(productId: Int) -> URL {
            return URL(string: "\(baseUrl)/products/\(productId)")!
        }
        static func deleteProduct(productId: Int) -> URL {
            return URL(string: "\(baseUrl)/products/\(productId)")!
        }
    }
    
        
}
