//
//  SehatQLabel.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/2/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class SehatQLabel: UILabel {
    
    var size: CGFloat!
    var color: UIColor!
    
    init(frame: CGRect, size: CGFloat, color: UIColor = UIColor.darkGray) {
        super.init(frame: frame)
        self.size = size
        self.color = color
        
        postinit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func postinit() {
        font = UIFont(name: "HelveticaNeue-Light", size: size)
        textColor = color
    }
}
