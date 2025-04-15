//
//  ContentView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State var camera: MapCameraPosition = .automatic
    
    let academy = CLLocationCoordinate2D(latitude: -8.737300, longitude: 115.175790)
    
    var body: some View {
        Map(position: $camera) {
            Marker("Academy", monogram: Text("ADA"), coordinate: academy)
                .tint(.green)
        }
    }
}

#Preview {
    ContentView()
}
