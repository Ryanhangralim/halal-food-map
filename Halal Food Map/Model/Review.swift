//
//  Review.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import Foundation

struct Review: Identifiable {
    var id = UUID()
    var username: String
    var rating: Int
    var uploadedAt: Date = .now
    var review: String
}
