//
//  DeleteProductResponseDTO.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/16/24.
//

import Foundation

struct DeleteProductResponseDTO: Codable {
    let deleted: Bool
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        deleted = try container.decode(Bool.self)
    }
}
