//
//  ProductListController.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/2/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class ProductListController: BaseController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var productModels: [ProductViewModel] = []
    var filteredProductModels: [ProductViewModel] = []
    
    var searchMode = false
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        
        initiateData()
        
        _ = searchBar.reactive.text.observeNext(with: {[weak self] (text) in
            if self != nil {
                if let textString = text, !textString.isEmpty {
                    self!.isSearching = true
                    self!.filteredProductModels.removeAll()
                    
                    self!.filteredProductModels = self!.productModels.filter {
                        return $0.title.lowercased().contains(textString.lowercased())
                    }
                    
                    self!.tableView.reloadData()
                    
                } else {
                    self!.isSearching = false
                    self!.filteredProductModels.removeAll()
                    
                    self!.tableView.reloadData()
                }  
            }
        })
    }
    
    func initiateData() {
        self.showActivity()
        productModels.removeAll()
        
        do {
            let data = try JSONSerialization.data(withJSONObject: mockData, options: .fragmentsAllowed)
            let products = try JSONDecoder().decode([Product].self, from: data)
            
            for product in products {
                let productModel = ProductViewModel(product: product)
                productModels.append(productModel)
            }
            
            self.hideActivity()
            tableView.reloadData()
            
        } catch {
            self.hideActivity()
            print("Error decoding: \(error)")
        }
    }
    
    func filterProduct(withSearchPhrase text: String) {
        
    }

}

extension ProductListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProductModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! ProductCell
        
        if filteredProductModels.count == 0 {
            return cell
        }
        
        let dataRow = filteredProductModels[indexPath.row]
        cell.item = dataRow
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredProductModels[indexPath.row]
        
        let detailController = storyboard?.instantiateViewController(identifier: "detail_scene") as! ProductDetailController
        detailController.selectedProduct = selectedProduct
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
