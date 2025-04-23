//
//  ContentView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//
import CoreLocation
import MapKit
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var restaurants: [Restaurant]
    @State private var viewModel: RestaurantViewModel?
    
    @State private var selectedDetent: PresentationDetent = .height(70)
    @State private var selectedRestaurant: Restaurant?
    @State private var showDetailSheet = false
    @State private var showAddRestaurantSheet = false
    
    // Add the location fetcher as a StateObject
    @StateObject private var locationFetcher = LocationFetcher()

    // Default location to use until we get user location
    @State private var currentCoordinate = CLLocationCoordinate2D(latitude: -8.737300, longitude: 115.175790)
    @State private var currentLocation = CLLocation(latitude: -8.737300, longitude: 115.175790)
    
    // Camera position state that we can update
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    // Flag to track if initial position has been set
    @State private var initialPositionSet = false

    var sortedRestaurants: [Restaurant] {
        return restaurants.sorted {
            let location1 = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
            let location2 = CLLocation(latitude: $1.latitude, longitude: $1.longitude)
            return location1.distance(from: currentLocation) < location2.distance(from: currentLocation)
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Map(position: $cameraPosition) {
                
                // Other restaurant pins
                ForEach(restaurants) { restaurant in
                    Annotation(restaurant.name, coordinate: restaurant.coordinate){
                        Pin(rating: restaurant.averageRating)
                            .onTapGesture {
                                selectedRestaurant = restaurant
                            }
                    }
                }
                
                // Custom circle to represent "current location"
                Annotation("You", coordinate: currentCoordinate) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 20, height: 20)
                        )
                        .shadow(radius: 4)
                }
            }
            .mapControls {}
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            
            // Add button
            Button(action: {
                showAddRestaurantSheet = true
            }) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    )
                    .shadow(radius: 4)
                    .padding(24)
            }
            .offset(y: -90)
        }
        .ignoresSafeArea()
        .sheet(isPresented: .constant(true)) {
            VStack(alignment: .leading, spacing: 20) {
                if (selectedDetent == .height(70)){
                    Text("Swipe to see details")
                        .foregroundColor(.secondary)
                        .offset(y: 10)
                } else {
                    ScrollView(.vertical){
                        LazyVStack{
                            ForEach(sortedRestaurants) { restaurant in
                                Button {
                                    selectedRestaurant = restaurant
                                } label: {
                                    RestaurantCardView(restaurant: restaurant, currentLocation: currentLocation)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 15)
                }
            }
            .presentationDetents([.height(70), .fraction(0.99)], selection: $selectedDetent)
            .interactiveDismissDisabled() // disable dismiss
            .presentationBackgroundInteraction(.enabled(upThrough: .height(70))) // Enable interaction with components when sheet is on bottom
            .sheet(item: $selectedRestaurant) { restaurant in
                NavigationStack {
                    RestaurantDetailView(restaurant: restaurant, currentLocation: currentLocation)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    selectedRestaurant = nil
                                } label: {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                            }
                        }
                        .navigationBarTitleDisplayMode(.inline)
                }
                .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $showAddRestaurantSheet){
                AddRestaurantView(currentLocation: currentLocation)
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = RestaurantViewModel(modelContext: modelContext)
            }
            
            // Set up the callback before starting location updates
            locationFetcher.onLocationUpdate = { userLocation in
                // Update current location
                currentCoordinate = userLocation
                currentLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
                
                // Update camera position to center on user location
                // Only center automatically on first location update
                if !initialPositionSet {
                    cameraPosition = .region(
                        MKCoordinateRegion(
                            center: userLocation,
                            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                        )
                    )
                    initialPositionSet = true
                }
            }
            
            // Start the location fetcher
            locationFetcher.start()
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [Restaurant.self, Review.self], inMemory: true)
}
