//
//  BaseExtension.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

extension UIView {
    func roundedCorner() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
