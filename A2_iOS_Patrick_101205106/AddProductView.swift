//
//  AddProductView.swift
//  A2_iOS_Patrick_101205106
//
//  Created by Patrick Millares on 2026-04-09.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @State private var id = ""
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    @State private var provider = ""
    
    var isFormInvalid: Bool {
        name.trimmingCharacters(in: .whitespaces).isEmpty ||
        id.trimmingCharacters(in: .whitespaces).isEmpty ||
        Double(price) == nil
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Product ID (Numbers only)", text: $id)
                        .keyboardType(.numberPad)
                    TextField("Product Name", text: $name)
                    TextField("Product Description", text: $description)
                    TextField("Price (e.g. 19.99)", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Provider", text: $provider)
                }
                
                if isFormInvalid && !name.isEmpty {
                    Section {
                        Text("Please enter a valid Name, ID, and Price.")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
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
                    .disabled(isFormInvalid)
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
            try viewContext.save()
            dismiss()
        } catch {
            print("Error: \(error)")
        }
    }
}
