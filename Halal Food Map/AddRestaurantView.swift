//
//  AddRestaurantView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 21/04/25.
//

import SwiftUI
import MapKit

struct AddRestaurantView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []

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
                List(searchResults, id: \.self) { item in
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
            if let response = response {
                searchResults = response.mapItems
            }
        }
    }
}


#Preview {
    AddRestaurantView()
}
