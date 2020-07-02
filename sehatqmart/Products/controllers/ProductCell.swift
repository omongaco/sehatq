//
//  ProductCell.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/2/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var item: ProductViewModel! {
        didSet {
            productImage.image = UIImage(named: "image_placeholder")
            
            if item.image == nil {
                APIService.getImage(withUrl: item.imageUrl) {[weak self] (image, error) in
                    if self != nil {
                        if let proImage = image {
                            self!.item.image = proImage
                            self!.productImage.image = proImage
                        }
                    }
                }
                
            } else {
                self.productImage.image = item.image
            }
            
            
            productName.text = item.title
            productPrice.text = item.price
        }
    }
    
    override func prepareForReuse() {
        productImage.image = nil
        productName.text = ""
        productPrice.text = ""
    }

}
