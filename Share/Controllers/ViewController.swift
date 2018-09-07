//
//  ViewController.swift
//  Share
//
//  Created by Caryl Rabanos on 04/09/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var fNameTxtField: UITextField!
    @IBOutlet weak var lNameTxtField: UITextField!
    @IBOutlet weak var contactNumberTxtField: UITextField!
    @IBOutlet weak var emergencyContactTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func RegisterControl(_ sender: UIButton) {
        guard let email = emailTxtField.text, let password = passwordTxtField.text, let Fname = fNameTxtField.text, let Lname = lNameTxtField.text, let Contact = contactNumberTxtField.text, let EmergencyContact = emergencyContactTxtField.text
            else{
            print("Form invalid!")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user,error) in
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
            let ref = Database.database().reference(fromURL: "https://share-a8ca4.firebaseio.com/")
            let values = ["Fname": Fname, "Lname": Lname, "Contact Number": Contact,"Emergency Contract": EmergencyContact]
            let uid = Auth.auth().currentUser?.uid
            ref.child("users").child(uid!).setValue(values, withCompletionBlock: {(err,ref) in
                if err != nil{
                    print(err?.localizedDescription as Any)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        })
        
    }
    @IBAction func loginPage(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

