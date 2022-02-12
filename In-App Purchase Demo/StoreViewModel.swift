//
//  Store.swift
//  In-App Purchase Demo
//
//  Created by Yusuf Çağlar on 12.02.2022.
//

import SwiftUI
import StoreKit

class StoreViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var purchasedIDs: [String] = []
    
    func fetchProducts() {
        
        Task.init(priority: .background) {
            
            do {
                let products = try await Product.products(for: ["com.premium.world1"])
                DispatchQueue.main.async {
                    self.products = products
                }
                
                if let product = products.first {
                    await isPurchased(product: product)
                }
                
            } catch {
                print("There's an error fetching products. \(error.localizedDescription)")
            }
        }
    }
    
    func isPurchased(product: Product) async {
        
        guard let state = await product.currentEntitlement else { return }
        
        switch state {
        case .verified(let transaction):
            DispatchQueue.main.async {
                self.purchasedIDs.append(transaction.productID)
            }
        case .unverified(_, _):
            break
        }
        
        
        
    }
    
    func purchase() {
        
        Task.init(priority: .background) {
            
            guard let product = products.first else { return }
            
            do {
                let result = try await product.purchase()
                
                switch result {
                    
                case .success(let verification):
                    switch verification {
                    case .verified(let transaction):
                        DispatchQueue.main.async {
                            self.purchasedIDs.append(transaction.productID)
                        }
                    case .unverified(_, _):
                        break
                    }
                case .userCancelled:
                    break
                case .pending:
                    break
                @unknown default:
                    break
                }
            } catch {
                print("There's an error purchasing products. \(error.localizedDescription)")
            }
        }
    }
    
}
