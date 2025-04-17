//
//  Halal_Food_MapApp.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import SwiftData
import SwiftUI

@main
struct Halal_Food_MapApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Restaurant.self)
    }
}
