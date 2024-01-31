//
//  CategoryResponseDTO.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/31/24.
//

import Foundation


struct CategoriesResponseDTO: Codable {
    let id: Int
    let name: String
    let image: String
    let creationAt, updatedAt: String
}
