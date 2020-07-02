//
//  ProductViewModel.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class ProductViewModel {
    var product: Product!
    
    init(product: Product) {
        self.product = product
    }
    
    var id: String {
        return product.id
    }
    
    var imageUrl: String {
        return product.imageUrl
    }
    
    var title: String {
        return product.title
    }
    
    var description: String {
        return product.description
    }
    
    var price: String {
        return product.price
    }
    
    var loved: Int {
        get {
            return product.loved
        }
        set {
            product.loved = newValue
        }
    }

    var image: UIImage?
}

extension ProductViewModel {
    func addLoved() {
        loved += 1
    }
    
    func saveProduct() {
        if let purchasedData = UserDefaults.standard.object(forKey: "purchased_items") as? Data {
            let decoder = JSONDecoder()
            if var products = try? decoder.decode([Product].self, from: purchasedData) {
                products.append(self.product)
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(products) {
                    UserDefaults.standard.set(encoded, forKey: "purchased_items")
                }
            }
            
        } else {
            let products:[Product] = [self.product]
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(products) {
                UserDefaults.standard.set(encoded, forKey: "purchased_items")
            }
        }
    }
}
