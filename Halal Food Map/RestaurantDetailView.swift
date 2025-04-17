//
//  RestaurantDetailView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 16/04/25.
//

import CoreLocation
import SwiftData
import SwiftUI

struct RestaurantDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let restaurant: Restaurant
    let currentLocation: CLLocation
    
    @State private var isAddingReview = false
    @State private var reviewText = ""
    @State private var reviewRating = 3
    
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
                    
                    Text("\(formattedDistance(from: currentLocation, to: restaurant.location))")
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
                    // Header + Add Review Button
                    HStack {
                        Text("Rate & Review")
                            .font(.title3)
                            .fontWeight(.semibold)

                        Spacer()

                        Button(action: {
                            reviewText = ""
                            reviewRating = 3
                            
                            withAnimation {
                                isAddingReview.toggle()
                            }
                        }) {
                            Text(isAddingReview ? "Cancel" : "Add Review")
                                .font(.caption)
                                .foregroundStyle(.white)
                                .padding(6)
                                .background(isAddingReview ? Color.red : Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }

                    // Rating summary
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(String(format: "%.1f", restaurant.averageRating))")
                            .bold()
                        Text("(\(restaurant.reviews.count) Reviews)")
                            .foregroundColor(.secondary)
                    }

                    // If adding, show input fields
                    if isAddingReview {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Your Review").bold()

                            HStack{
                                Spacer()
                                RatingView(rating: $reviewRating)
                                Spacer()
                            }
                            
                            TextEditor(text: $reviewText)
                                .frame(height: 80)
                                .padding(8)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 8))


                            HStack {
                                Spacer()
                                Button(action: {
                                    // Create the new review
                                    let newReview = Review(username: "Anonymous", rating: reviewRating, uploadedAt: Date(), review: reviewText)
                                    
                                    // Associate the review with the restaurant and insert it into SwiftData
                                    restaurant.reviews.append(newReview)

                                    reviewText = ""
                                    reviewRating = 3
                                    withAnimation {
                                        isAddingReview = false
                                    }
                                }) {
                                    Text("Add Review")
                                        .bold()
                                        .padding(10)
                                        .background(Color.blue)
                                        .foregroundStyle(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Spacer()
                            }
                            .padding(.top, 8)
                        }
                        .padding(.vertical)
                    } else {
                        // Show existing reviews
                        ForEach(restaurant.reviews) { review in
                            ReviewCard(review: review)
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
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
