//
//  SwipeButton.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 15/04/25.
//

import SwiftUI

struct SwipeButton: View {
    var action: () -> Void
    @State private var isDragging = false
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .frame(height: 85)
                .shadow(color: .black.opacity(0.2), radius: 5)
            
            VStack {
                // Drag indicator
                Capsule()
                    .fill(Color.secondary.opacity(0.4))
                    .frame(width: 70, height: 5)
                    .offset(y: -10)
                
                Text("Swipe to see details")
                    .foregroundColor(.secondary)
                    .offset(y: -2)
            }
        }
        .frame(maxWidth: .infinity)
        // Handle swipe gesture
        .gesture(
            DragGesture(minimumDistance: 10)
                .onChanged { value in
                    if value.translation.height < 0 {
                        isDragging = true
                        dragOffset = min(0, value.translation.height)
                    }
                }
                .onEnded { value in
                    if isDragging && value.translation.height < -30 {
                        action()
                    }
                    isDragging = false
                    dragOffset = 0
                }
        )
        // Add tap gesture too
        .onTapGesture {
            action()
        }
        .offset(y: dragOffset)
        .animation(.spring(), value: dragOffset)
    }
}

#Preview {
    SwipeButton {
        
    }
}
