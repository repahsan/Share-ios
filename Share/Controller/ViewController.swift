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
import GoogleMaps

class ViewController: UIViewController {

    var googleApiKey = "AIzaSyCp0xOx8p6ROiquRXqT53038ujLHbdRMRw"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // var ref: DatabaseReference!
        
       // ref = Database.database().reference(fromURL: "Argument labels '(_:)' do not match any available overloads")
       // ref.updateChildValues(["Somevalues":123123])

       
        // User not logged in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        }
        
        
        //Homepage
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Maps", style: .plain, target: self, action: #selector(handleMaps))
        
        
       
    
        
    }
    
    @objc func handleLogout(){
        
        do{
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true,completion:nil)
    }

    
    @objc func handleMaps() {
        let mapController = MapController()
        present(mapController, animated: true, completion: nil)
        
    }
}

