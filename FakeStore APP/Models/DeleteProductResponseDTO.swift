//
//  DeleteProductResponseDTO.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/16/24.
//

import Foundation

struct DeleteProductSuccessResponseDTO: Codable {
    
    let deleted: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        deleted = try container.decode(Bool.self)
    }
}

struct DeleteProductErrorResponseDTO: Codable {
    let path, timestamp, name, message: String
}
