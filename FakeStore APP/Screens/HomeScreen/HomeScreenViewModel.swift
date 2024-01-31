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
}
