//
//  HomeProductCell.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/2/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class HomeProductCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var lovedLabel: UILabel!
    @IBOutlet weak var lovedButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: ProductViewModel! {
        didSet {
            productImage.image = UIImage(named: "image_placeholder")
            
            APIService.getImage(withUrl: item.imageUrl) {[weak self] (image, error) in
                if let proImage = image {
                    self?.productImage.image = proImage
                }
            }
            
            productName.text = item.title
            lovedLabel.text = "\(item.loved) Loves"
        }
    }
    
    override func prepareForReuse() {
        productName.text = ""
        productImage.image = nil
        lovedLabel.text = ""
    }

}
