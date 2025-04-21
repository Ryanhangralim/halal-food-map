//
//  LocationUtils.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 17/04/25.
//

import Foundation
import CoreLocation

// Location formatter
func formattedDistance(from location1: CLLocation, to location2: CLLocation) -> String {
    let distanceInMeters = location1.distance(from: location2)

    if distanceInMeters < 1000 {
        return "\(Int(distanceInMeters)) m"
    } else {
        let distanceInKm = distanceInMeters / 1000
        return String(format: "%.1f km", distanceInKm)
    }
}

// Fetch user location
class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
