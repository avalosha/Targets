//
//  Book.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 15/02/24.
//

import Foundation

class Book {
    
}

struct UserBook {
    var products = Set<String>()
    
    mutating func buy(_ product: String) {
        products.insert(product)
    }
    
    func owns(_ product: String) -> Bool {
        return product.contains(product)
    }
}
