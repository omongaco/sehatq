//
//  ProductDetailController.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/2/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class ProductDetailController: BaseController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var sharedButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var lovedButton: UIButton!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var selectedProduct: ProductViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
        populateData()
    }
    
    func populateData() {
        if selectedProduct != nil {
            //  Load Image
            if selectedProduct!.image != nil {
                productImage.image = selectedProduct?.image
            } else {
                APIService.getImage(withUrl: selectedProduct!.imageUrl) {[weak self] (image, error) in
                    if self != nil {
                        if let proImage = image {
                            self!.selectedProduct!.image = proImage
                            self!.productImage.image = proImage
                        }
                    }
                }
            }
            
            productName.text = selectedProduct!.title
            productDescription.text = selectedProduct!.description
            productPrice.text = selectedProduct!.price
        }
    }
    
    @IBAction func buyClicked() {
        if selectedProduct != nil {
            selectedProduct!.saveProduct()
        }
    }

}
