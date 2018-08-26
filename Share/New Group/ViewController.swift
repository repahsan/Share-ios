//
//  ViewController.swift
//  Share
//
//  Created by Caryl Rabanos on 19/08/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }

    @objc func handleLogout(){
        let loginController = LoginController()
        present(loginController, animated: true,completion:nil)
    }


}

