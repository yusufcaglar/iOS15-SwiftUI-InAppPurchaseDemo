//
//  ContentView.swift
//  In-App Purchase Demo
//
//  Created by Yusuf Çağlar on 12.02.2022.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    @StateObject private var storeModel = StoreViewModel()
    
    //MARK: - Body
    var body: some View {
        
        GeometryReader { geometry in
            
            LazyVStack(alignment: .center, spacing: 32) {
                Text("Premium World!")
                    .font(.largeTitle)
                    .foregroundColor(Color.blue)
                    .bold()
                
                HStack {
                    
                    if storeModel.purchasedIDs.isEmpty {
                    Image(systemName: "globe.europe.africa")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.gray)
                    } else {
                        Image(systemName: "globe.europe.africa.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 125, height: 125)
                            .foregroundColor(Color.cyan)
                    }
                    
                }
                .frame(width: geometry.size.width - 32, alignment: .center)
                
                if let product = storeModel.products.first {
                    VStack(spacing: 8) {
                        if storeModel.purchasedIDs.isEmpty {
                        Text(product.displayName)
                        Text(product.description)
                        } else {
                            Text("You have premium world!")
                                .foregroundColor(Color.blue)
                                .bold()
                                .font(.title2)
                        }
                    }
                    
                    Button {
                        if storeModel.purchasedIDs.isEmpty {
                            storeModel.purchase()
                        }
                    } label: {
                        Text(storeModel.purchasedIDs.isEmpty ? "Buy now for \(product.displayPrice)" : "Purchased")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: geometry.size.width - 32, height: 50, alignment: .center)
                            .background(storeModel.purchasedIDs.isEmpty ? Color.pink : Color.green)
                            .cornerRadius(12)
                        
                    }
                }
                
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            storeModel.fetchProducts()
        }
    }
}
//MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
