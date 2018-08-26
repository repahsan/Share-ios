//
//  ViewController.swift
//  Share
//
//  Created by Caryl Rabanos on 19/08/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // var ref: DatabaseReference!
        
       // ref = Database.database().reference(fromURL: "Argument labels '(_:)' do not match any available overloads")
       // ref.updateChildValues(["Somevalues":123123])
      
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }

    @objc func handleLogout(){
        let loginController = LoginController()
        present(loginController, animated: true,completion:nil)
    }


}

