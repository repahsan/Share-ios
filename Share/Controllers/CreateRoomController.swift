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
        create()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func create(){
        let ref = Database.database().reference(fromURL: "https://share-a8ca4.firebaseio.com/")
        let refer = ref.child("travel").childByAutoId()
        let romid = refer.key
        refer.setValue(["Available": 1,"Destination": Destination,"Origin": Origin,"NoOfUsers": "1","Fare":1])
        let userId = Auth.auth().currentUser?.uid
        ref.child("travel").child(romid!).child("users").setValue(["Leader":userId])
        id = romid!
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
