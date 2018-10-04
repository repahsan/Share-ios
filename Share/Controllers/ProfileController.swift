//
//  ProfileController.swift
//  Share
//
//  Created by Caryl Rabanos on 07/09/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    let ref = Database.database().reference(fromURL: "https://share-a8ca4.firebaseio.com/")
    let id = Auth.auth().currentUser?.uid
    @IBOutlet weak var button : UIButton!
    var Pin : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("users").child(id!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let pin = value?["Pin"] as? Int
            print(pin as Any)
            if(pin == 0){
                
            }
        }){(error) in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MapsAction(_ sender: UIButton) {
    
            self.performSegue(withIdentifier: "MapsSegue", sender: self)
    }
    @IBAction func signOutAction(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "LogoutSegue", sender: self)
        } catch let err {
            print(err)
        }
        
    }
    func createAlert(title:String,message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let subButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(subButton)
        self.present(alert, animated: true, completion: nil)
    }
}
