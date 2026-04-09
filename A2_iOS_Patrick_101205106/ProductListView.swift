//
//  Untitled.swift
//  A2_iOS_Patrick_101205106
//
//  Created by Patrick Millares on 2026-04-09.
//

import SwiftUI

struct ProductListView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)])
    private var products: FetchedResults<Product>
    
    @State private var searchText = ""
    
    // Logic to filter products by Name OR Description
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.productName ?? "").localizedCaseInsensitiveContains(searchText) ||
                ($0.productDescription ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        List(filteredProducts) { product in
            VStack(alignment: .leading) {
                Text(product.productName ?? "Unknown Product")
                    .font(.headline)
                Text(product.productDescription ?? "No description available")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .navigationTitle("All Products")
        .searchable(text: $searchText, prompt: "Search name or description")
    }
}
