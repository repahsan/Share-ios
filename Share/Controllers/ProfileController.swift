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
    @IBOutlet weak var emergencyNumlabel: UILabel!
    @IBOutlet weak var contactNumlabel: UILabel!
    @IBOutlet weak var genderlabel: UILabel!
    @IBOutlet weak var lastNamelabel: UILabel!
    @IBOutlet weak var firstNamelabel: UILabel!
    let ref = Database.database().reference(fromURL: "https://share-a8ca4.firebaseio.com/")
    let id = Auth.auth().currentUser?.uid
    @IBOutlet weak var button : UIButton!
    var Pin : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("users").child(id!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let pin = value?["Pin"] as? Int
            self.firstNamelabel.text = value?["Fname"] as? String
            self.lastNamelabel.text = value?["Lname"] as? String
            self.genderlabel.text = value?["Gender"] as? String
            self.contactNumlabel.text = value?["Contact Number"] as? String
            self.emergencyNumlabel.text = value?["Emergency Contact"] as? String
            if(pin == 0){
                self.createAlert()
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
    func createAlert()
    {
        let alertController = UIAlertController(title: "Enter 4 digit pin number", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { alert -> Void in
            let pin = Int(alertController.textFields![0].text!)
            self.ref.child("users").child(self.id!).updateChildValues(["Pin" : pin as Any])
        })
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
