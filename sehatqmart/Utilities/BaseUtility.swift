//
//  BaseUtility.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class BaseUtility {
    
    static func roundedCorner(view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
    }
    
    static func setParentChildConstraint(child: UIView, parent: UIView, top: CGFloat, trailing: CGFloat, bottom: CGFloat, leading: CGFloat) {
        child.translatesAutoresizingMaskIntoConstraints = false
        
        child.topAnchor.constraint(equalTo: parent.topAnchor, constant: top).isActive = true
        child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: trailing).isActive = true
        child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: bottom).isActive = true
        child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: leading).isActive = true
    }
}
