//
//  RestaurantDetailView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 16/04/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0) {
                // Top section: Name, certification, category, distance
                VStack(alignment: .leading, spacing: 2) {
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
                    
                    Text("\(restaurant.category)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("\(restaurant.distance)")
                        .font(.headline)
                        .padding(.bottom, 4)
                }
                .padding(.bottom, 8)
                
                // Images section
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 5) {
                        ForEach(0..<5) { _ in
                            Image("test")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .clipped()
                        }
                    }
                }
                .padding(.bottom, 12)
                
                // Address section
                VStack(alignment: .leading, spacing: 2) {
                    Text("Address")
                        .font(.headline)
                    
                    Text("\(restaurant.address)")
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 10)
                
                // Rate & Review Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Rate & Review")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button(action: {
                            // Add review logic here
                        }) {
                            Text("Add Review")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(6)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("4.1")
                            .bold()
                        Text("(10 Reviews)")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    
                    ForEach(Review.dummyData) { review in
                        ReviewCard(review: review)
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 15))

            }
            .padding(.horizontal,20) // Main content padding
            
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: .init(
            name: "Amanaia", category: "Indonesian Restaurant", distance: "60 m", address: "Jl. Kediri, Tuban, Kec. Kuta, Bali, 80361" ,avgRating: 4.5, totalReviews: 2, isCertified: true, latitude: -8.736982293243265, longitude: 115.17502036325229
        ))
        .previewLayout(.sizeThatFits)
    }
}

//                HStack(spacing: 4) {
//                    Image(systemName: "star.fill")
//                        .foregroundColor(.yellow)
//                    Text("\(String(format: "%.1f", restaurant.avgRating)) (\(restaurant.totalReviews))")
//                        .font(.subheadline)
//                        .foregroundStyle(.primary)
//                }
