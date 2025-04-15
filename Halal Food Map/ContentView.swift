//
//  ContentView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    
    let academy = CLLocationCoordinate2D(latitude: -8.737300, longitude: 115.175790)
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -8.737300, longitude: 115.175790),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    )
    
    var body: some View {
        ZStack(alignment: .bottom){
            Map(initialPosition: startPosition) {
                // Custom circle to represent "current location"
                Annotation("", coordinate: academy) {
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
                
                // Other restaurant pins (dummy data)
                ForEach(Restaurant.dummyData) { restaurant in
                    Annotation(restaurant.name, coordinate: restaurant.coordinate){
                        Pin(rating: restaurant.avgRating)
                    }
                }
            }
            .mapStyle(.standard(pointsOfInterest: .including([.restaurant, .cafe])))
            .ignoresSafeArea()
            
            // Swipe/tap button that triggers the sheet
            SwipeButton {
                showingSheet = true
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showingSheet) {
            // Your sheet content
            VStack(alignment: .leading, spacing: 20) {
                Text("FUTURE CONTENT")
            }
            .padding()
            .presentationDetents([.height(800)])
            .presentationDragIndicator(.visible)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct RestaurantSheetView: View {
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 6)
                .padding(.top)

            Text("Restaurant Details")
                .font(.title2)
                .bold()
                .padding(.top)

            List {
                Text("🍛 Sate Ayam - 4.3⭐")
                Text("🍛 Nasi Padang - 4.1⭐")
                Text("🍔 KFC - 4.2⭐")
                Text("🥣 Chicken Porridge - 4.5⭐")
                // Add more dummy data or pull from your `Restaurant` model
            }
        }
    }
}


#Preview {
    ContentView()
}
