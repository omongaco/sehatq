//
//  Product.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import Foundation

class Product: Codable {
    let id: String
    let imageUrl: String
    let title: String
    let description: String
    let price: String
    var loved: Int
}
