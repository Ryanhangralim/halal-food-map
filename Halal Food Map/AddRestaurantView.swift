//
//  AddRestaurantView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 21/04/25.
//

import SwiftUI
import MapKit

struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let mapItem: MKMapItem
    let distance: CLLocationDistance
}

struct AddRestaurantView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText = ""
    @State private var searchResults: [SearchResult] = []
    
    @State var currentLocation: CLLocation?

    var body: some View {
        NavigationStack {
            VStack {
                // Search bar
                TextField("Search for a restaurant", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onSubmit {
                        search()
                    }
                
                // Search results with built-in navigation
                List(searchResults, id: \.id) { result in
                    let item = result.mapItem
                    NavigationLink(destination: RestaurantFormView(
                        name: item.name ?? "",
                        address: item.placemark.title ?? "",
                        latitude: item.placemark.coordinate.latitude,
                        longitude: item.placemark.coordinate.longitude,
                        onSubmit: {
                            dismiss()
                        }
                    )) {
                        VStack(alignment: .leading) {
                            Text(item.name ?? "Unknown")
                                .font(.headline)
                            Text(item.placemark.title ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            let distanceInKm = result.distance / 1000.0
                            Text(String(format: "%.2f km away", distanceInKm))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Add Restaurant")
        }
    }

    func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response, let userLocation = currentLocation else { return }

            let resultsWithDistance = response.mapItems.map { item in
                let itemLocation = CLLocation(
                    latitude: item.placemark.coordinate.latitude,
                    longitude: item.placemark.coordinate.longitude
                )
                let distance = userLocation.distance(from: itemLocation)
                return SearchResult(mapItem: item, distance: distance)
            }
            .sorted { $0.distance < $1.distance } // Sort by distance ascending

            searchResults = resultsWithDistance
        }
    }
}


#Preview {
    AddRestaurantView()
}
