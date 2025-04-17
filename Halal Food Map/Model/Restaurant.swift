//
//  Restaurant.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import Foundation
import MapKit
import SwiftData

@Model
class Restaurant: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var address: String
    var isCertified: Bool
    var latitude: Double
    var longitude: Double
    
    @Relationship(deleteRule: .cascade)
    var reviews: [Review]
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    // Compute average rating
    var averageRating: Double {
        guard !reviews.isEmpty else { return 0.0 }
        let totalRating = reviews.reduce(0) { $0 + $1.rating }
        return Double(totalRating) / Double(reviews.count)
    }
    
    init(id: UUID = UUID(), name: String, category: String, address: String, isCertified: Bool, latitude: Double, longitude: Double, reviews: [Review]) {
        self.id = id
        self.name = name
        self.category = category
        self.address = address
        self.isCertified = isCertified
        self.latitude = latitude
        self.longitude = longitude
        self.reviews = reviews
    }
}

extension Restaurant {
    static let dummyData: [Restaurant] = [
        Restaurant(
            name: "Amanaia",
            category: "Indonesian Restaurant",
            address: "Jl. Kediri, Tuban, Kec. Kuta, Bali, 80361",
            isCertified: true,
            latitude: -8.736982293243265,
            longitude: 115.17502036325229,
            reviews: [
                Review(username: "Ali", rating: 5, uploadedAt: .randomLast30Days, review: "Authentic and delicious!"),
                Review(username: "Dewi", rating: 4, uploadedAt: .randomLast30Days, review: "Nice place, friendly staff."),
                Review(username: "Dewi2", rating: 4, uploadedAt: .randomLast30Days, review: "Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff."),
                Review(username: "Dewi3", rating: 4, uploadedAt: .randomLast30Days, review: "Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff."),
                Review(username: "Dewi4", rating: 4, uploadedAt: .randomLast30Days, review: "Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.Nice place, friendly staff.")
            ]
        ),
        Restaurant(
            name: "Mai3 Cafegan Vegetarian Cafe",
            category: "Vegan Restaurant",
            address: "6X, Jl. Raya Tuban No.1, Tuban, Kec. Kuta, Kabupaten Badung, Bali 80361",
            isCertified: false,
            latitude: -8.740937412998631,
            longitude: 115.17889090610126,
            reviews: [
                Review(username: "Budi", rating: 5, uploadedAt: .randomLast30Days, review: "Best vegan food I’ve tried!"),
                Review(username: "Sinta", rating: 3, uploadedAt: .randomLast30Days, review: "Food was okay but portion was small.")
            ]
        ),
        Restaurant(
            name: "Warung Sate Madura",
            category: "Satay Restaurant",
            address: "Jl Kediri No K8, Tuban, Kec. Kuta, Kabupaten Badung, Bali 80361",
            isCertified: false,
            latitude: -8.737620829020402,
            longitude: 115.17731537963436,
            reviews: [
                Review(username: "Wawan", rating: 4, uploadedAt: .randomLast30Days, review: "Tasty satay and spicy sauce."),
                Review(username: "Rina", rating: 5, uploadedAt: .randomLast30Days, review: "Hidden gem!")
            ]
        ),
        Restaurant(
            name: "Richeese Factory Kuta",
            category: "Fast food",
            address: "Jl. Raya Kuta No.131B, Kuta, Kec. Kuta, Kabupaten Badung, Bali 80361",
            isCertified: true,
            latitude: -8.735108903350465,
            longitude: 115.1778232661139,
            reviews: [
                Review(username: "Joko", rating: 4, uploadedAt: .randomLast30Days, review: "Cheese lovers’ paradise."),
                Review(username: "Yuni", rating: 3, uploadedAt: .randomLast30Days, review: "Busy and a bit slow service.")
            ]
        ),
        Restaurant(
            name: "Holland Bakery Tuban Kuta",
            category: "Bakery",
            address: "Jl. Raya Tuban No.99, Tuban, Kec. Kuta, Kabupaten Badung, Bali 80361",
            isCertified: true,
            latitude: -8.739601464969834,
            longitude: 115.17861790210725,
            reviews: [
                Review(username: "Sari", rating: 5, uploadedAt: .randomLast30Days, review: "Always fresh bread."),
                Review(username: "Indra", rating: 4, uploadedAt: .randomLast30Days, review: "Nice variety and clean.")
            ]
        ),
        Restaurant(
            name: "Warung Nasi Ayam Bu Oki",
            category: "Balinese Restaurant",
            address: "Jl. Raya Tuban No.3, Tuban, Kec. Kuta, Kabupaten Badung, Bali 80361",
            isCertified: false,
            latitude: -8.743698362140202,
            longitude: 115.17918582835517,
            reviews: [
                Review(username: "Putri", rating: 5, uploadedAt: .randomLast30Days, review: "Super flavorful and spicy!"),
                Review(username: "Agus", rating: 5, uploadedAt: .randomLast30Days, review: "My go-to spot for lunch.")
            ]
        ),
        Restaurant(
            name: "Nasi Pedas Ibu Andika",
            category: "Rice Restaurant",
            address: "Jl. Raya Kuta No.100, Kuta, Kec. Kuta, Kabupaten Badung, Bali 80361",
            isCertified: false,
            latitude: -8.726735738329467,
            longitude: 115.1766869118225,
            reviews: [
                Review(username: "Mega", rating: 4, uploadedAt: .randomLast30Days, review: "Super spicy and cheap!"),
                Review(username: "Bayu", rating: 4, uploadedAt: .randomLast30Days, review: "Good portion and flavor.")
            ]
        )
    ]
}

extension Date {
    static var randomLast30Days: Date {
        let daysAgo = Int.random(in: 0..<30)
        return Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()
    }
}
