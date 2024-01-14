//
//  FakeStore_APPApp.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

@main
struct FakeStore_APPApp: App {
    @StateObject private var session = SessionManager()
    var body: some Scene {
        WindowGroup {
          MainAppScreen()
                .environmentObject(session)
        }
    }
}
