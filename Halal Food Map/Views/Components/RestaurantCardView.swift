//
//  RestaurantCardView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import CoreLocation
import SwiftUI

struct RestaurantCardView: View {
    let restaurant: Restaurant
    let currentLocation: CLLocation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(restaurant.name)
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                    
                    if restaurant.isCertified {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 0) {
                            HStack(spacing: 2) {
                                Text("Halal Certified")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.green)
                                    .font(.caption)
                            }
                            
                            Text("(IDxxxxxxxxxxxxxxxxxx)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                }

                Text("\(restaurant.category) · \(formattedDistance(from: currentLocation, to: restaurant.location))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(String(format: "%.1f", restaurant.averageRating)) (\(restaurant.reviews.count))")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 5) {
                    ForEach(0..<5) { _ in
                        Image("test")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                    }
                }
            }
        }
        .padding(15)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
        .frame(width: UIScreen.main.bounds.width - 30) // Set specific width
        .frame(maxHeight: 200) // Set maximum height
        .padding(.bottom, 5) // Add padding from bottom of screen
    }
}

struct RestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCardView(restaurant: .init(
                name: "Amanaia",
                category: "Indonesian Restaurant",
                address: "Jl. Kediri, Tuban, Kec. Kuta, Bali, 80361",
                isCertified: true,
                latitude: -8.736982293243265,
                longitude: 115.17502036325229,
                reviews: [
                    Review(username: "Ali", rating: 5, uploadedAt: .randomLast30Days, review: "Authentic and delicious!"),
                    Review(username: "Dewi", rating: 4, uploadedAt: .randomLast30Days, review: "Nice place, friendly staff.")
                ]
        ),
       currentLocation: CLLocation(latitude: -8.737300, longitude: 115.175790))
        .previewLayout(.sizeThatFits)
    }
}
