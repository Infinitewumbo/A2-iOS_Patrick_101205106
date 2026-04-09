//
//  Untitled.swift
//  A2_iOS_Patrick_101205106
//
//  Created by Patrick Millares on 2026-04-09.
// Patrick Millares 101205106

import SwiftUI
import CoreData

struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)])
    private var products: FetchedResults<Product>
    
    @State private var searchText = ""
    
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
        List {
            ForEach(filteredProducts) { product in
                // NavigationLink allows tapping a product to see details
                NavigationLink(destination: ProductDetailView(product: product)) {
                    VStack(alignment: .leading) {
                        Text(product.productName ?? "Unknown Product")
                            .font(.headline)
                        Text(product.productDescription ?? "No description")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
            }
            .onDelete(perform: deleteProducts)
        }
        .navigationTitle("All Products")
        .searchable(text: $searchText, prompt: "Search name or description")
    }

    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredProducts[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("Delete error: \(error)")
            }
        }
    }
}

struct ProductDetailView: View {
    let product: Product
    var body: some View {
        List {
            Section(header: Text("Product Info")) {
                Text("Name: \(product.productName ?? "")")
                Text("ID: \(product.productId)")
                Text("Price: $\(String(format: "%.2f", product.productPrice))")
                Text("Provider: \(product.productProvider ?? "")")
            }
            Section(header: Text("Description")) {
                Text(product.productDescription ?? "")
            }
        }
        .navigationTitle("Details")
    }
}
