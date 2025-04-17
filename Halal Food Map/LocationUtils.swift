//
//  LocationUtils.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 17/04/25.
//

import Foundation
import CoreLocation

func formattedDistance(from location1: CLLocation, to location2: CLLocation) -> String {
    let distanceInMeters = location1.distance(from: location2)

    if distanceInMeters < 1000 {
        return "\(Int(distanceInMeters)) m"
    } else {
        let distanceInKm = distanceInMeters / 1000
        return String(format: "%.1f km", distanceInKm)
    }
}
