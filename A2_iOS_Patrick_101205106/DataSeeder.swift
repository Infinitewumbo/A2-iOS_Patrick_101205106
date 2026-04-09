//
//  DataSeeder.swift
//  A2_iOS_Patrick_101205106
//
//  Created by Patrick Millares on 2026-04-09.
//
import CoreData

struct DataSeeder {
    static func seedProducts(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let count = try context.count(for: request)
            
            // Only add products if the database is empty
            if count == 0 {
                let providers = ["TechCorp", "GadgetWorld", "Innovation Inc"]
                
                for i in 1...10 {
                    let newProduct = Product(context: context)
                    newProduct.productId = Int64(100 + i)
                    newProduct.productName = "Product \(i)"
                    newProduct.productDescription = "High-quality description for Product \(i) which is excellent for daily use."
                    newProduct.productPrice = Double(i) * 19.99
                    newProduct.productProvider = providers.randomElement() ?? "General Provider"
                }
                
                try context.save()
                print("Successfully seeded 10 products.")
            }
        } catch {
            print("Error seeding data: \(error)")
        }
    }
}
