//
//  Restaurant.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import Foundation
import MapKit

struct Restaurant: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var distance: String
    var address: String
    var avgRating: Double
    var totalReviews: Int
    var isCertified: Bool
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Restaurant {
    static let dummyData: [Restaurant] = [
        Restaurant(name: "Amanaia", category: "Indonesian Restaurant", distance: "60 m", address: "Jl. Kediri, Tuban, Kec. Kuta, Bali, 80361" ,avgRating: 4.5, totalReviews: 2, isCertified: true, latitude: -8.736982293243265, longitude: 115.17502036325229),
        Restaurant(name: "Warung Sate Madura", category: "Satay Restaurant", distance: "160 m", address: "Jl Kediri No K8, Tuban, Kec. Kuta, Kabupaten Badung, Bali 80361", avgRating: 4.2, totalReviews: 10, isCertified: false, latitude: -8.737620829020402, longitude: 115.17731537963436),
        Restaurant(name: "Richeese Factory Kuta", category: "Fast food", distance: "500 m", address: "Jl. Raya Kuta No.131B, Kuta, Kec. Kuta, Kabupaten Badung, Bali 80361", avgRating: 4.0, totalReviews: 1000, isCertified: true, latitude: -8.735108903350465, longitude: 115.1778232661139),
        Restaurant(name: "Holland Bakery Tuban Kuta", category: "Bakery", distance: "550 m", address: "Jl. Raya Tuban No.99, Tuban, Kec. Kuta, Kabupaten Badung, Bali 80361", avgRating: 4.5, totalReviews: 200, isCertified: true, latitude: -8.739601464969834, longitude: 115.17861790210725),
        Restaurant(name: "Warung Nasi Ayam Bu Oki", category: "Balinese Restaurant", distance: "1.0 km", address: "Jl. Raya Tuban No.3, Tuban, Kec. Kuta, Kabupaten Badung, Bali 80361", avgRating: 4.4, totalReviews: 1700, isCertified: false, latitude: -8.743698362140202, longitude: 115.17918582835517),
        Restaurant(name: "Nasi Pedas Ibu Andika", category: "Rice Restaurant", distance: "1.4 km", address: "Jl. Raya Kuta No.100, Kuta, Kec. Kuta, Kabupaten Badung, Bali 80361", avgRating: 4.1, totalReviews: 4000, isCertified: false, latitude: -8.726735738329467, longitude: 115.1766869118225)
    ]
}
