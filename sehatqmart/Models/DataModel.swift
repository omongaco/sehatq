//
//  DataModel.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/2/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import Foundation

class Model: Codable {
    let data: DataModel
}

class DataModel: Codable {
    let category: [Category]
    let productPromo:[Product]
}
