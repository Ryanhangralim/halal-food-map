//
//  Pin.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import SwiftUI
import MapKit

struct Pin: View {
    var rating: Double

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 34, height: 34)
                Text(String(format: "%.1f", rating))
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            Triangle()
                .fill(Color.green)
                .frame(width: 20, height: 10)
                .offset(y: -3)
        }
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

// Simple triangle shape to act as the pin's pointer
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))        // Bottom center
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))     // Top left
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))     // Top right
        path.closeSubpath()
        return path
    }
}


#Preview {
    Pin(rating: 4.2)
}
