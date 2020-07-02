//
//  BaseController.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showAlert(withTitle title: String?, _ message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showActivity() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator?.center = self.view.center
            activityIndicator?.hidesWhenStopped = true
            self.view.addSubview(activityIndicator!)
        }
        
        activityIndicator?.startAnimating()
    }
    
    func hideActivity() {
        if activityIndicator != nil {
            activityIndicator?.stopAnimating()
        }
    }

}
