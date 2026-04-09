//
//  AddProductView.swift
//  A2_iOS_Patrick_101205106
//
//  Created by Patrick Millares on 2026-04-09.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    // State variables for each required attribute
    @State private var id = ""
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    @State private var provider = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Product ID", text: $id)
                        .keyboardType(.numberPad)
                    TextField("Product Name", text: $name)
                    TextField("Product Description", text: $description)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Provider", text: $provider)
                }
            }
            .navigationTitle("Add New Product")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveProduct()
                    }
                    .disabled(name.isEmpty || id.isEmpty)
                }
            }
        }
    }

    private func saveProduct() {
        let newProduct = Product(context: viewContext)
        newProduct.productId = Int64(id) ?? 0
        newProduct.productName = name
        newProduct.productDescription = description
        newProduct.productPrice = Double(price) ?? 0.0
        newProduct.productProvider = provider

        do {
            try viewContext.save() // Save to Core Data
            dismiss()
        } catch {
            print("Error saving product: \(error)")
        }
    }
}
