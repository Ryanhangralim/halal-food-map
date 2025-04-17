//
//  RestaurantViewModel.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 17/04/25.
//

import Foundation
import SwiftData

@Observable
class RestaurantViewModel {
    var restaurants: [Restaurant] = []

    init(modelContext: ModelContext) {
        Task {
            await seedDummyDataIfNeeded(modelContext: modelContext)
        }
    }

    func seedDummyDataIfNeeded(modelContext: ModelContext) async {
        do {
            let fetchRequest = FetchDescriptor<Restaurant>()
            let existing = try modelContext.fetch(fetchRequest)

            if existing.isEmpty {
                for restaurant in Restaurant.dummyData {
                    modelContext.insert(restaurant)
                }
                try modelContext.save()
            }

            restaurants = try modelContext.fetch(fetchRequest)
        } catch {
            print("Failed to seed or fetch: \(error)")
        }
    }
}
