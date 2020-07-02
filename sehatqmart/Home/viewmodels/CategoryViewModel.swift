//
//  CategoryViewModel.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import Foundation

class CategoryViewModel {
    var category: Category!
    
    init(category: Category) {
        self.category = category
    }
    
    var id: Int {
        return category.id
    }
    
    var imageUrl: String {
        return category.imageUrl
    }
    
    var name: String {
        return category.name
    }
}

extension CategoryViewModel {
    func getCategory() -> Category {
        return self.category
    }
}
