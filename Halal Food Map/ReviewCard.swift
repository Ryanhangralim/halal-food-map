//
//  ReviewCard.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 16/04/25.
//

import SwiftUI

struct ReviewCard: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top) {
                Image("profile")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(review.username)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            
                        
                        Spacer()
                        
                        Button(action: {
                            // Reply action
                        }) {
                            HStack(spacing: 2) {
                                Image(systemName: "arrowshape.turn.up.left")
                                Text("Reply")
                            }
                            .font(.caption)
                            .foregroundStyle(.blue)
                        }
                    }
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: "star.fill")
                                    .foregroundStyle(index < Int(review.rating) ? .yellow : .gray)
                                    .font(.caption)
                        }
                        
                        Text("·")
                            .foregroundStyle(.secondary)
                        
                        Text("\(timeAgoString(from: review.uploadedAt))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Text(review.review)
                        .font(.footnote)
                        .foregroundStyle(.primary)
                        .padding(.top, 8)
                }
            }
        }
    }
    
    func timeAgoString(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full // or .full for "2 days ago" instead of "2d ago"
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

#Preview {
    ReviewCard(review: Review(username: "Capybara", rating: 3, uploadedAt: Date().addingTimeInterval(-3600), review: "This place is fire bro"))
}
