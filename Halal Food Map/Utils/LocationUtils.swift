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
class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    
    @Published var lastKnownLocation: CLLocationCoordinate2D? {
        didSet {
            // This will fire whenever the location changes
            if let location = lastKnownLocation {
                onLocationUpdate?(location)
            }
        }
    }
    
    // Add a callback closure property
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?

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
