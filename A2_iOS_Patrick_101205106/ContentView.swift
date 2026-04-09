//
//  ContentView.swift
//  A2_iOS_Patrick_101205106
//
//  Created by Patrick Millares on 2026-04-09.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch all products sorted by ID
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.productId, ascending: true)])
    private var products: FetchedResults<Product>
    
    // Track which product is currently being viewed
    @State private var currentIndex: Int = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if !products.isEmpty {
                    let currentProduct = products[currentIndex]
                    
                    // Product Details Card
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Product ID: \(currentProduct.productId)")
                            .font(.headline)
                        Text(currentProduct.productName ?? "No Name")
                            .font(.title).bold()
                        Text(currentProduct.productDescription ?? "No Description")
                            .font(.body)
                        Text("Price: $\(String(format: "%.2f", currentProduct.productPrice))")
                            .foregroundColor(.green)
                        Text("Provider: \(currentProduct.productProvider ?? "Unknown")")
                            .font(.subheadline).italic()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // Navigation Buttons (Requirement: "allow user to navigate through all products")
                    HStack {
                        Button(action: { if currentIndex > 0 { currentIndex -= 1 } }) {
                            Label("Previous", systemImage: "arrow.left")
                        }
                        .disabled(currentIndex == 0)
                        
                        Spacer()
                        
                        Text("\(currentIndex + 1) of \(products.count)")
                        
                        Spacer()
                        
                        Button(action: { if currentIndex < products.count - 1 { currentIndex += 1 } }) {
                            Label("Next", systemImage: "arrow.right")
                        }
                        .disabled(currentIndex == products.count - 1)
                    }
                    .padding()
                    
                } else {
                    Text("No products found.")
                }
            }
            .navigationTitle("Product Details")
            .padding()
        }
    }
}
