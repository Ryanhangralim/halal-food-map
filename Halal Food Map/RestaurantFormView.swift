//
//  RestaurantFormView.swift
//  Halal Food Map
//
//  Created by Ryan Hangralim on 21/04/25.
//

import SwiftData
import SwiftUI

struct RestaurantFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State var name: String = ""
    @State var address: String = ""
    @State var latitude: Double = 0.0
    @State var longitude: Double = 0.0
    @State var category: String = ""
    @State var isCertified: Bool = false

    var onSubmit: (() -> Void)?
    
    // ✅ Computed property to check if form is valid
    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !address.trimmingCharacters(in: .whitespaces).isEmpty &&
        !category.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Restaurant Info")) {
                    TextField("Name", text: $name)
                    TextField("Address", text: $address)
                    HStack {
                        Text("Latitude")
                        Spacer()
                        Text(String(format: "%.6f", latitude))
                    }
                    HStack {
                        Text("Longitude")
                        Spacer()
                        Text(String(format: "%.6f", longitude))
                    }
                    TextField("Category", text: $category)
                    Toggle("Certified Halal", isOn: $isCertified)
                }

                Button("Add Restaurant") {
                    let newRestaurant = Restaurant(
                        name: name,
                        category: category,
                        address: address,
                        isCertified: isCertified,
                        latitude: latitude,
                        longitude: longitude,
                        reviews: []
                    )
                    modelContext.insert(newRestaurant)
                    
                    onSubmit?() // Dismiss the AddRestaurantView
                    dismiss()
                }
                .disabled(!isFormValid) // ✅ Disable button when invalid
                .opacity(isFormValid ? 1 : 0.5) // Optional visual feedback
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Add Restaurant")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RestaurantFormView()
}
