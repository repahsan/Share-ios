//
//  CreateRoomController.swift
//  Share
//
//  Created by Caryl Rabanos on 07/10/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase
var ExtraMembers = 0;
class CreateRoomController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let ref = Database.database().reference(fromURL: "https://share-a8ca4.firebaseio.com/")
        let refer = ref.child("travel").childByAutoId()
        let id = refer.key
        refer.setValue(["Available": 1,"Destination": Destination,"Origin": Origin,])
        let userId = Auth.auth().currentUser?.uid
        ref.child("travel").child(id!).child("users").setValue(["Leader":userId])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
