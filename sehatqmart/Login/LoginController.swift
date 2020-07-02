//
//  LoginController.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit

class LoginController: BaseController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    var rememberMe = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUserInterface()
    }
    
    func setupUserInterface() {
        // Initiate remember button color
        rememberButton.imageView?.tintColor = UIColor.lightGray
        
        signButton.roundedCorner()
        facebookButton.roundedCorner()
        googleButton.roundedCorner()
    }
    
    @IBAction func loginClicked() {
        if let userName = usernameField.text, userName.isEmpty {
            self.showAlert(withTitle: "Error", "Please fill username")
            return
        }
        
        if let password = passwordField.text, password.isEmpty {
            self.showAlert(withTitle: "Error", "Please fill password")
            return
        }
        
        let homeController = storyboard?.instantiateViewController(withIdentifier: "main_scene")
        homeController?.modalPresentationStyle = .overCurrentContext
        
        self.present(homeController!, animated: true, completion: nil)
    }
    
    @IBAction func rememberClicked() {
        rememberMe = rememberMe ? false : true
        
        if rememberMe {
            rememberButton.imageView?.tintColor = UIColor.red
        } else {
            rememberButton.imageView?.tintColor = UIColor.lightGray
        }
    }
}
