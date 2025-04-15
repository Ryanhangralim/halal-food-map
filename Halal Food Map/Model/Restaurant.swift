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
    var avgRating: Double
    var totalReviews: Int
    var isCertified: Bool
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
