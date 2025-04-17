//
//  Review.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import Foundation
import SwiftData

@Model
class Review: Identifiable {
    var id = UUID()
    var username: String
    var rating: Int
    var uploadedAt: Date = Date()
    var review: String
    
    init(id: UUID = UUID(), username: String, rating: Int, uploadedAt: Date = Date(), review: String) {
        self.id = id
        self.username = username
        self.rating = rating
        self.uploadedAt = uploadedAt
        self.review = review
    }
}

extension Review {
    static let dummyData: [Review] = [
        Review(username: "Capybara", rating: 5, review: "This place is fire bro"),
        Review(username: "Red Panda", rating: 5, review: "What he said"),
        Review(username: "Test", rating: 4, review: "test test test testset test testst steset sejts telsjtlsj lejlej kjeljlkjelj ejlkjelksj kljeljl kjeeese"),
        Review(username: "Test", rating: 4, review: "test test test testset test testst steset sejts telsjtlsj lejlej kjeljlkjelj ejlkjelksj kljeljl kjeeese"),
        Review(username: "Test", rating: 4, review: "test test test testset test testst steset sejts telsjtlsj lejlej kjeljlkjelj ejlkjelksj kljeljl kjeeese"),
        Review(username: "Test", rating: 4, review: "test test test testset test testst steset sejts telsjtlsj lejlej kjeljlkjelj ejlkjelksj kljeljl kjeeese"),
        Review(username: "Test", rating: 4, review: "test test test testset test testst steset sejts telsjtlsj lejlej kjeljlkjelj ejlkjelksj kljeljl kjeeese")
    ]
}
