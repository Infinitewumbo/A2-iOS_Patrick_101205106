//
//  ContentView.swift
//  A2_iOS_Patrick_101205106
//
//  Created by Patrick Millares on 2026-04-09.
// Patrick Millares 101205106

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.productId, ascending: true)])
    private var products: FetchedResults<Product>
    
    @State private var currentIndex: Int = 0
    @State private var showingAddSheet = false

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                if !products.isEmpty {
                    let currentProduct = products[currentIndex]
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("ID: \(currentProduct.productId)")
                                .font(.caption.bold())
                                .padding(6)
                                .background(Color.blue.opacity(0.3))
                                .cornerRadius(5)
                            Spacer()
                            Text(currentProduct.productProvider ?? "Unknown")
                                .font(.caption)
                                .italic()
                        }
                        
                        Text(currentProduct.productName ?? "No Name")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        Divider()
                        
                        Text(currentProduct.productDescription ?? "No Description")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("$\(String(format: "%.2f", currentProduct.productPrice))")
                            .font(.title3.bold())
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5))
                    .padding(.horizontal)
                    
                    // Navigation Controls
                    HStack {
                        Button(action: { if currentIndex > 0 { currentIndex -= 1 } }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.largeTitle)
                        }
                        .disabled(currentIndex == 0)
                        
                        Spacer()
                        Text("\(currentIndex + 1) of \(products.count)")
                            .font(.headline)
                        Spacer()
                        
                        Button(action: { if currentIndex < products.count - 1 { currentIndex += 1 } }) {
                            Image(systemName: "chevron.right.circle.fill")
                                .font(.largeTitle)
                        }
                        .disabled(currentIndex == products.count - 1)
                    }
                    .padding(.horizontal, 40)
                    
                } else {
                    ContentUnavailableView("No Products", systemImage: "box.truck", description: Text("Tap + to add your first product."))
                }
            }
            .navigationTitle("Product Details")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProductListView()) {
                        Image(systemName: "list.dash")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddProductView()
            }
        }
    }
}
