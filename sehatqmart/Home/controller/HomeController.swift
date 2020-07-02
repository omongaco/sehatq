//
//  HomeController.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit
import Bond

class HomeController: BaseController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var categoryModels: [CategoryViewModel] = []
    var productModels: [ProductViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        tableView.tableFooterView = UIView()
        initiateData()
        
        _ = searchBar.searchTextField.reactive.controlEvents(.editingDidBegin).observeNext(with: { [weak self]_ in
            self?.view.endEditing(true)
            self?.tabBarController?.selectedIndex = 1
        })
    }
    
    func initiateData() {
        self.showActivity()
        categoryModels = []
        productModels = []
        
        DispatchQueue.global(qos: .background).async {
            APIService.getHomeObjects {[weak self] (response, error) in
                if let data = response {
                    do {
                        let models = try JSONDecoder().decode([Model].self, from: data)
                        for model in models {
                            for category in model.data.category {
                                let categoryModel = CategoryViewModel(category: category)
                                self?.categoryModels.append(categoryModel)
                            }
                            
                            for product in model.data.productPromo {
                                let productModel = ProductViewModel(product: product)
                                self?.productModels.append(productModel)
                            }
                            
                            DispatchQueue.main.async {
                                self?.hideActivity()
                                self?.setupUserInterface()
                            }
                        }
                    } catch {
                        print("Cannot parse with error: \(error)")
                    }
                }
            }
        }
    }
    
    func setupUserInterface() {
        setupCategoryContainer()
        tableView.reloadData()
    }
    
    func setupCategoryContainer() {
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        BaseUtility.setParentChildConstraint(child: stackView, parent: scrollView, top: 0, trailing: 0, bottom: 0, leading: 0)
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0).isActive = true
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        for category in categoryModels {
            let categoryStack = UIStackView()
            stackView.addArrangedSubview(categoryStack)
            categoryStack.axis = .vertical
            categoryStack.alignment = .center
            categoryStack.spacing = 2
            categoryStack.widthAnchor.constraint(equalToConstant: scrollView.frame.size.height).isActive = true
            
            let imageView = UIImageView()
            categoryStack.addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
            imageView.contentMode = .scaleAspectFit
            
            let label = SehatQLabel(frame: CGRect(), size: 12, color: .red)
            categoryStack.addArrangedSubview(label)
            label.text = category.name
            
            APIService.getImage(withUrl: category.imageUrl) { (response, error) in
                if let imageResponse = response {
                    imageView.image = imageResponse
                }
            }
        }
    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 243
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! HomeProductCell
        
        if productModels.count == 0 {
            return cell
        }
        
        cell.item = productModels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(identifier: "detail_scene") as! ProductDetailController
        detailController.selectedProduct = productModels[indexPath.row]
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
