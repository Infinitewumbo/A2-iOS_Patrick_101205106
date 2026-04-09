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
    
    var body: some View {
        List(products) { product in
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
    }
}
