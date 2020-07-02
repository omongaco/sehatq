//
//  PurchasedHistoryController.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/2/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class PurchasedHistoryController: BaseController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var purchasedProductModels: [ProductViewModel] = []
    var filteredProductModels: [ProductViewModel] = []
    
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        
        _ = searchBar.reactive.text.observeNext(with: {[weak self] (text) in
            if self != nil {
                if let textString = text, !textString.isEmpty {
                    self!.isSearching = true
                    self!.filteredProductModels.removeAll()
                    
                    self!.filteredProductModels = self!.purchasedProductModels.filter {
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
    
    override func viewWillAppear(_ animated: Bool) {
        initiatePurchasedDate()
    }
    
    func initiatePurchasedDate() {
        self.showActivity()
        purchasedProductModels.removeAll()
        
        if let purchasedData = UserDefaults.standard.object(forKey: "purchased_items") as? Data {
            let decoder = JSONDecoder()
            if let products = try? decoder.decode([Product].self, from: purchasedData) {
                for product in products {
                    let productModel = ProductViewModel(product: product)
                    purchasedProductModels.append(productModel)
                }
                
                self.hideActivity()
                tableView.reloadData()
            }
        }
    }
}

extension PurchasedHistoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isSearching ? filteredProductModels.count : purchasedProductModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! ProductCell
        
        if isSearching && filteredProductModels.count == 0 {
            return cell
        }
        
        let dataRow = isSearching ? filteredProductModels[indexPath.row] : purchasedProductModels[indexPath.row]
        cell.item = dataRow
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedProduct: ProductViewModel?
        selectedProduct = isSearching ? filteredProductModels[indexPath.row] : purchasedProductModels[indexPath.row]
        
        let detailController = storyboard?.instantiateViewController(identifier: "detail_scene") as! ProductDetailController
        detailController.selectedProduct = selectedProduct
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
